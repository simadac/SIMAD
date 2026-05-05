# Implementação solicitada

Foram integradas ao SIMAD as funcionalidades do `teste2` para o agente cadastrar novas ocorrências.

## O que foi alterado

- `frontend/agente.html`
  - Botão **Nova ocorrência** no cabeçalho e na aba de ocorrências.
  - Modal de cadastro de ocorrência para agente.
  - Campos de título, tipo, urgência, descrição, CEP, bairro, endereço, latitude, longitude, observação e fotos.
  - Upload de fotos com pré-visualização, remoção, clique para selecionar e arrastar/soltar.
  - Envio via `fetch()` para `POST http://localhost:5000/api/ocorrencias`.
  - Consulta geral em `GET /api/ocorrencias`.
  - Atualização de status em `PUT /api/ocorrencias/<id>/status`.

- `backend/app.py`
  - Arquivo principal com todas as conexões ao banco centralizadas nele.
  - Rotas Flask de ocorrências implementadas no próprio arquivo principal.
  - Conexão MySQL por variáveis do `.env`.
  - CORS habilitado.
  - Salvamento de fotos na tabela `fotos_ocorrencia`.

- `database/schema.sql`
  - Estrutura do banco `simad`.
  - Tabelas `usuarios`, `ocorrencias` e `fotos_ocorrencia`.
  - Campo `caminho_foto` como `LONGTEXT` para aceitar Base64 no MVP.

## Como rodar o backend

```bash
cd backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
copy .env.example .env
python app.py
```

No Linux/Mac:

```bash
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
python app.py
```

Teste se a API está rodando:

```text
http://localhost:5000/api/ping
```

## Banco de dados

Execute o arquivo:

```text
database/schema.sql
```

Depois ajuste os dados do banco no arquivo:

```text
backend/.env
```

## Observação importante

O GitHub Pages só roda o front-end. O backend Flask precisa ficar rodando localmente ou em algum serviço externo, como Render, Railway ou PythonAnywhere.
