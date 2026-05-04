/*
    SIMAD - Sistema Integrado de Monitoramento e Alerta de Desastres
    Arquivo: seeds.sql
    Finalidade: Inserção de dados iniciais para testes e validação do banco
*/

INSERT INTO bairros (nome) VALUES
('Centro'),
('Botujuru'),
('Jardim América'),
('Jardim Laura'),
('Parque Internacional'),
('Vila Chacrinha'),
('São José'),
('Campo Verde');

INSERT INTO tipos_ocorrencia (nome, descricao) VALUES
('Alagamento', 'Acúmulo de água em via, imóvel ou área pública.'),
('Deslizamento', 'Movimento de massa, escorregamento ou instabilidade de encosta.'),
('Árvore com risco', 'Árvore com risco de queda, galhos comprometidos ou dano estrutural aparente.'),
('Incêndio', 'Princípio de incêndio, queimada ou ocorrência relacionada a fogo.'),
('Imóvel com risco', 'Edificação com risco aparente ou possível comprometimento estrutural.'),
('Erosão', 'Processo erosivo em solo, via, margem ou talude.'),
('Outro', 'Ocorrência não enquadrada nas categorias anteriores.');

INSERT INTO status_ocorrencia (nome, descricao, finaliza_ocorrencia) VALUES
('Recebida', 'Ocorrência registrada pelo morador e aguardando análise.', 0),
('Em análise', 'Ocorrência sendo analisada pela Defesa Civil.', 0),
('Aprovada', 'Solicitação aprovada para acompanhamento.', 0),
('Rejeitada', 'Solicitação rejeitada por ausência de elementos ou inadequação.', 1),
('Em atendimento', 'Ocorrência em atendimento pela equipe responsável.', 0),
('Resolvida', 'Ocorrência resolvida pela Defesa Civil.', 1),
('Encaminhada', 'Ocorrência encaminhada a outro setor ou órgão.', 0);

INSERT INTO usuarios (
    nome, email, senha_hash, telefone, cpf, perfil
) VALUES
('João da Silva', 'joao@email.com', '123456_hash_exemplo', '(11) 90000-0001', '000.000.000-01', 'morador'),
('Maria Oliveira', 'maria@email.com', '123456_hash_exemplo', '(11) 90000-0002', '000.000.000-02', 'morador'),
('Agente Defesa Civil', 'agente@defesacivil.com', 'admin123_hash_exemplo', '(11) 90000-0003', '000.000.000-03', 'agente'),
('Administrador SIMAD', 'admin@simad.com', 'admin123_hash_exemplo', '(11) 90000-0004', '000.000.000-04', 'administrador');

INSERT INTO ocorrencias (
    protocolo,
    id_morador,
    id_tipo,
    id_status,
    id_bairro,
    titulo,
    descricao,
    nivel_urgencia,
    cep,
    logradouro,
    numero,
    complemento,
    cidade,
    estado,
    latitude,
    longitude,
    aprovado
) VALUES (
    'SIMAD-2026-0001',
    1,
    1,
    1,
    1,
    'Ponto de alagamento na via pública',
    'Morador informa acúmulo de água na rua após chuva intensa.',
    'alta',
    '13230-000',
    'Rua de Teste',
    '100',
    'Próximo à praça',
    'Campo Limpo Paulista',
    'SP',
    -23.20600000,
    -46.78400000,
    NULL
);
