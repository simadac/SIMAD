"""
app.py — SIMAD
Arquivo principal do backend Flask.

Neste arquivo ficam:
- criação do servidor Flask;
- configuração do CORS;
- conexão com o banco de dados MySQL;
- rotas da API de ocorrências.

Execute com:
    python app.py
"""

import os
from datetime import datetime

import mysql.connector
from dotenv import load_dotenv
from flask import Flask, jsonify, request
from flask_cors import CORS

# ============================================================
# VARIÁVEIS DE AMBIENTE E CONEXÃO COM BANCO
# ============================================================
# O arquivo .env deve ficar na mesma pasta deste app.py.
load_dotenv()


def get_connection():
    """
    Abre uma conexão com o banco MySQL.

    Todas as conexões com o banco ficam centralizadas neste arquivo
    principal, conforme solicitado. Para mudar usuário, senha, host ou
    banco definitivo, altere apenas o arquivo .env.
    """
    return mysql.connector.connect(
        host=os.getenv("DB_HOST", "localhost"),
        user=os.getenv("DB_USER", "root"),
        password=os.getenv("DB_PASSWORD", ""),
        database=os.getenv("DB_NAME", "simad"),
        port=int(os.getenv("DB_PORT", 3306)),
        charset="utf8mb4",
        use_pure=True,
    )


# ============================================================
# CRIAÇÃO DO APP FLASK
# ============================================================
app = Flask(__name__)
CORS(app, origins="*")


# ============================================================
# ROTAS BÁSICAS
# ============================================================
@app.route("/api/ping", methods=["GET"])
def ping():
    return jsonify({"status": "ok", "sistema": "SIMAD"}), 200


# ============================================================
# POST /api/ocorrencias
# Cadastra uma nova ocorrência enviada pelo morador ou agente
# ============================================================
@app.route("/api/ocorrencias", methods=["POST"])
def cadastrar_ocorrencia():
    dados = request.get_json() or {}

    campos_obrigatorios = ["titulo", "descricao"]
    for campo in campos_obrigatorios:
        if not dados.get(campo):
            return jsonify({"erro": f"Campo obrigatório ausente: {campo}"}), 400

    # Como o agente também pode cadastrar ocorrência, caso não exista
    # morador real vinculado, usamos o próprio usuário/agente como origem.
    id_morador = dados.get("id_morador") or dados.get("id_agente") or 1
    id_agente = dados.get("id_agente")

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        sql = """
            INSERT INTO ocorrencias
                (titulo, tipo_ocorrencia, descricao, cep, endereco, bairro,
                 cidade, estado, latitude, longitude, urgencia, status,
                 id_morador, id_agente_responsavel, observacao_agente,
                 comentario_interno, equipe, data_criacao, data_atualizacao)
            VALUES
                (%s, %s, %s, %s, %s, %s,
                 %s, %s, %s, %s, %s, 'pendente',
                 %s, %s, %s,
                 %s, %s, %s, %s)
        """

        valores = (
            dados.get("titulo"),
            dados.get("tipo_ocorrencia", "Geral"),
            dados.get("descricao"),
            dados.get("cep"),
            dados.get("endereco"),
            dados.get("bairro"),
            dados.get("cidade", "Campo Limpo Paulista"),
            dados.get("estado", "SP"),
            dados.get("latitude"),
            dados.get("longitude"),
            dados.get("urgencia", "medio"),
            id_morador,
            id_agente,
            dados.get("observacao_agente"),
            dados.get("comentario_interno", "Ocorrência criada pelo painel do agente" if id_agente else None),
            dados.get("equipe"),
            datetime.now(),
            datetime.now(),
        )

        cursor.execute(sql, valores)
        id_novo = cursor.lastrowid

        # Fotos podem vir do front-end como Base64 no campo "fotos".
        # Para produção, o ideal é salvar em uma pasta/storage e gravar
        # no banco apenas o caminho do arquivo.
        fotos = dados.get("fotos", [])
        for foto in fotos:
            caminho_foto = foto.get("caminho_foto") if isinstance(foto, dict) else foto
            if not caminho_foto:
                continue

            cursor.execute(
                """
                    INSERT INTO fotos_ocorrencia
                        (id_ocorrencia, caminho_foto, data_upload)
                    VALUES
                        (%s, %s, %s)
                """,
                (id_novo, caminho_foto, datetime.now()),
            )

        conn.commit()
        return jsonify({"mensagem": "Ocorrência cadastrada com sucesso", "id": id_novo}), 201

    except Exception as e:
        conn.rollback()
        return jsonify({"erro": str(e)}), 500

    finally:
        cursor.close()
        conn.close()


# ============================================================
# GET /api/ocorrencias
# Lista todas as ocorrências para o agente, com filtros opcionais
# ============================================================
@app.route("/api/ocorrencias", methods=["GET"])
def listar_ocorrencias():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        condicoes = []
        valores = []

        status = request.args.get("status")
        tipo = request.args.get("tipo_ocorrencia")
        bairro = request.args.get("bairro")
        data_inicio = request.args.get("data_inicio")
        data_fim = request.args.get("data_fim")

        if status:
            condicoes.append("o.status = %s")
            valores.append(status)
        if tipo:
            condicoes.append("o.tipo_ocorrencia = %s")
            valores.append(tipo)
        if bairro:
            condicoes.append("o.bairro LIKE %s")
            valores.append(f"%{bairro}%")
        if data_inicio:
            condicoes.append("DATE(o.data_criacao) >= %s")
            valores.append(data_inicio)
        if data_fim:
            condicoes.append("DATE(o.data_criacao) <= %s")
            valores.append(data_fim)

        where_clause = "WHERE " + " AND ".join(condicoes) if condicoes else ""

        sql = f"""
            SELECT
                o.*,
                u.nome AS morador_nome,
                u.telefone AS morador_telefone,
                ag.nome AS agente_nome
            FROM ocorrencias o
            LEFT JOIN usuarios u  ON o.id_morador = u.id
            LEFT JOIN usuarios ag ON o.id_agente_responsavel = ag.id
            {where_clause}
            ORDER BY o.data_criacao DESC
        """
        cursor.execute(sql, valores)
        ocorrencias = cursor.fetchall()
        return jsonify(_serializar_lista(ocorrencias)), 200

    except Exception as e:
        return jsonify({"erro": str(e)}), 500

    finally:
        cursor.close()
        conn.close()


# ============================================================
# GET /api/ocorrencias/<id>
# Busca uma ocorrência específica e suas fotos
# ============================================================
@app.route("/api/ocorrencias/<int:id_ocorrencia>", methods=["GET"])
def buscar_ocorrencia(id_ocorrencia):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        sql = """
            SELECT
                o.*,
                u.nome  AS morador_nome,
                u.email AS morador_email,
                ag.nome AS agente_nome
            FROM ocorrencias o
            LEFT JOIN usuarios u  ON o.id_morador = u.id
            LEFT JOIN usuarios ag ON o.id_agente_responsavel = ag.id
            WHERE o.id = %s
        """
        cursor.execute(sql, (id_ocorrencia,))
        ocorrencia = cursor.fetchone()

        if not ocorrencia:
            return jsonify({"erro": "Ocorrência não encontrada"}), 404

        cursor.execute(
            "SELECT * FROM fotos_ocorrencia WHERE id_ocorrencia = %s ORDER BY data_upload DESC",
            (id_ocorrencia,),
        )
        ocorrencia["fotos"] = cursor.fetchall()

        return jsonify(_serializar(ocorrencia)), 200

    except Exception as e:
        return jsonify({"erro": str(e)}), 500

    finally:
        cursor.close()
        conn.close()


# ============================================================
# GET /api/ocorrencias/morador/<id_morador>
# Lista ocorrências de um morador específico
# ============================================================
@app.route("/api/ocorrencias/morador/<int:id_morador>", methods=["GET"])
def listar_por_morador(id_morador):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        sql = """
            SELECT
                o.*,
                ag.nome AS agente_nome
            FROM ocorrencias o
            LEFT JOIN usuarios ag ON o.id_agente_responsavel = ag.id
            WHERE o.id_morador = %s
            ORDER BY o.data_criacao DESC
        """
        cursor.execute(sql, (id_morador,))
        ocorrencias = cursor.fetchall()
        return jsonify(_serializar_lista(ocorrencias)), 200

    except Exception as e:
        return jsonify({"erro": str(e)}), 500

    finally:
        cursor.close()
        conn.close()


# ============================================================
# PUT /api/ocorrencias/<id>/status
# Agente atualiza status, equipe e observações
# ============================================================
@app.route("/api/ocorrencias/<int:id_ocorrencia>/status", methods=["PUT"])
def atualizar_status(id_ocorrencia):
    dados = request.get_json() or {}

    status_validos = ["pendente", "em_andamento", "aprovado", "resolvido", "rejeitado"]
    novo_status = dados.get("status")

    if not novo_status or novo_status not in status_validos:
        return jsonify({"erro": "Status inválido ou ausente"}), 400

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        sql = """
            UPDATE ocorrencias SET
                status                = %s,
                observacao_agente     = %s,
                comentario_interno    = %s,
                equipe                = %s,
                id_agente_responsavel = %s,
                data_atualizacao      = %s
            WHERE id = %s
        """
        valores = (
            novo_status,
            dados.get("observacao_agente"),
            dados.get("comentario_interno"),
            dados.get("equipe"),
            dados.get("id_agente"),
            datetime.now(),
            id_ocorrencia,
        )
        cursor.execute(sql, valores)

        if cursor.rowcount == 0:
            return jsonify({"erro": "Ocorrência não encontrada"}), 404

        conn.commit()
        return jsonify({"mensagem": "Status atualizado com sucesso"}), 200

    except Exception as e:
        conn.rollback()
        return jsonify({"erro": str(e)}), 500

    finally:
        cursor.close()
        conn.close()


# ============================================================
# TRATAMENTO DE ERROS
# ============================================================
@app.errorhandler(404)
def nao_encontrado(e):
    return jsonify({"erro": "Rota não encontrada"}), 404


@app.errorhandler(500)
def erro_interno(e):
    return jsonify({"erro": "Erro interno no servidor"}), 500


# ============================================================
# FUNÇÕES AUXILIARES
# ============================================================
def _serializar(obj):
    """Converte datetime para string antes de retornar em JSON."""
    for chave, valor in obj.items():
        if isinstance(valor, datetime):
            obj[chave] = valor.isoformat()
    return obj


def _serializar_lista(lista):
    return [_serializar(item) for item in lista]


# ============================================================
# EXECUÇÃO
# ============================================================
if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
