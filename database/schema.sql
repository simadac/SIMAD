/*
    SIMAD - Sistema Integrado de Monitoramento e Alerta de Desastres
    Arquivo: schema.sql
    Finalidade: Criação da estrutura do banco de dados relacional do SIMAD
    Banco utilizado: Azure SQL Database
    Ambiente: db-simad-dev
*/

CREATE TABLE usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    nome NVARCHAR(150) NOT NULL,
    email NVARCHAR(150) NOT NULL UNIQUE,
    senha_hash NVARCHAR(255) NOT NULL,
    telefone NVARCHAR(30),
    cpf NVARCHAR(20),
    perfil NVARCHAR(30) NOT NULL CHECK (
        perfil IN ('morador', 'agente', 'administrador')
    ),
    ativo BIT NOT NULL DEFAULT 1,
    criado_em DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    atualizado_em DATETIME2 NULL
);

CREATE TABLE bairros (
    id_bairro INT IDENTITY(1,1) PRIMARY KEY,
    nome NVARCHAR(120) NOT NULL UNIQUE,
    cidade NVARCHAR(120) NOT NULL DEFAULT 'Campo Limpo Paulista',
    estado CHAR(2) NOT NULL DEFAULT 'SP',
    ativo BIT NOT NULL DEFAULT 1
);

CREATE TABLE tipos_ocorrencia (
    id_tipo INT IDENTITY(1,1) PRIMARY KEY,
    nome NVARCHAR(100) NOT NULL,
    descricao NVARCHAR(MAX),
    ativo BIT NOT NULL DEFAULT 1
);

CREATE TABLE status_ocorrencia (
    id_status INT IDENTITY(1,1) PRIMARY KEY,
    nome NVARCHAR(80) NOT NULL,
    descricao NVARCHAR(MAX),
    finaliza_ocorrencia BIT NOT NULL DEFAULT 0
);

CREATE TABLE enderecos_usuario (
    id_endereco INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    cep NVARCHAR(20),
    logradouro NVARCHAR(150),
    numero NVARCHAR(30),
    complemento NVARCHAR(100),
    id_bairro INT NULL,
    cidade NVARCHAR(120) DEFAULT 'Campo Limpo Paulista',
    estado CHAR(2) DEFAULT 'SP',
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    criado_em DATETIME2 NOT NULL DEFAULT SYSDATETIME(),

    CONSTRAINT fk_endereco_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),

    CONSTRAINT fk_endereco_bairro
        FOREIGN KEY (id_bairro) REFERENCES bairros(id_bairro)
);

CREATE TABLE preferencias_notificacao (
    id_preferencia INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    receber_email BIT NOT NULL DEFAULT 1,
    receber_sms BIT NOT NULL DEFAULT 0,
    receber_whatsapp BIT NOT NULL DEFAULT 1,
    receber_push BIT NOT NULL DEFAULT 1,

    CONSTRAINT fk_preferencia_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE ocorrencias (
    id_ocorrencia INT IDENTITY(1,1) PRIMARY KEY,
    protocolo NVARCHAR(50) NOT NULL UNIQUE,

    id_morador INT NOT NULL,
    id_tipo INT NOT NULL,
    id_status INT NOT NULL,
    id_bairro INT NULL,

    titulo NVARCHAR(150) NOT NULL,
    descricao NVARCHAR(MAX) NOT NULL,

    nivel_urgencia NVARCHAR(30) NOT NULL CHECK (
        nivel_urgencia IN ('baixa', 'media', 'alta', 'critica')
    ),

    cep NVARCHAR(20),
    logradouro NVARCHAR(150),
    numero NVARCHAR(30),
    complemento NVARCHAR(100),
    cidade NVARCHAR(120) DEFAULT 'Campo Limpo Paulista',
    estado CHAR(2) DEFAULT 'SP',

    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),

    aprovado BIT NULL,
    motivo_rejeicao NVARCHAR(MAX),

    criado_em DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    atualizado_em DATETIME2 NULL,
    resolvido_em DATETIME2 NULL,

    CONSTRAINT fk_ocorrencia_morador
        FOREIGN KEY (id_morador) REFERENCES usuarios(id_usuario),

    CONSTRAINT fk_ocorrencia_tipo
        FOREIGN KEY (id_tipo) REFERENCES tipos_ocorrencia(id_tipo),

    CONSTRAINT fk_ocorrencia_status
        FOREIGN KEY (id_status) REFERENCES status_ocorrencia(id_status),

    CONSTRAINT fk_ocorrencia_bairro
        FOREIGN KEY (id_bairro) REFERENCES bairros(id_bairro)
);

CREATE TABLE fotos_ocorrencia (
    id_foto INT IDENTITY(1,1) PRIMARY KEY,
    id_ocorrencia INT NOT NULL,
    url_arquivo NVARCHAR(500) NOT NULL,
    nome_arquivo NVARCHAR(255),
    tipo_arquivo NVARCHAR(50),
    enviado_por INT NOT NULL,
    criado_em DATETIME2 NOT NULL DEFAULT SYSDATETIME(),

    CONSTRAINT fk_foto_ocorrencia
        FOREIGN KEY (id_ocorrencia) REFERENCES ocorrencias(id_ocorrencia),

    CONSTRAINT fk_foto_usuario
        FOREIGN KEY (enviado_por) REFERENCES usuarios(id_usuario)
);

CREATE TABLE historico_ocorrencia (
    id_historico INT IDENTITY(1,1) PRIMARY KEY,
    id_ocorrencia INT NOT NULL,
    id_usuario INT NOT NULL,

    acao NVARCHAR(100) NOT NULL,
    descricao NVARCHAR(MAX),

    id_status_anterior INT NULL,
    id_status_novo INT NULL,

    criado_em DATETIME2 NOT NULL DEFAULT SYSDATETIME(),

    CONSTRAINT fk_historico_ocorrencia
        FOREIGN KEY (id_ocorrencia) REFERENCES ocorrencias(id_ocorrencia),

    CONSTRAINT fk_historico_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),

    CONSTRAINT fk_historico_status_anterior
        FOREIGN KEY (id_status_anterior) REFERENCES status_ocorrencia(id_status),

    CONSTRAINT fk_historico_status_novo
        FOREIGN KEY (id_status_novo) REFERENCES status_ocorrencia(id_status)
);

CREATE TABLE atribuicoes_ocorrencia (
    id_atribuicao INT IDENTITY(1,1) PRIMARY KEY,
    id_ocorrencia INT NOT NULL,
    id_agente INT NOT NULL,
    atribuido_por INT NOT NULL,
    observacao NVARCHAR(MAX),
    criado_em DATETIME2 NOT NULL DEFAULT SYSDATETIME(),

    CONSTRAINT fk_atribuicao_ocorrencia
        FOREIGN KEY (id_ocorrencia) REFERENCES ocorrencias(id_ocorrencia),

    CONSTRAINT fk_atribuicao_agente
        FOREIGN KEY (id_agente) REFERENCES usuarios(id_usuario),

    CONSTRAINT fk_atribuicao_autor
        FOREIGN KEY (atribuido_por) REFERENCES usuarios(id_usuario)
);

CREATE TABLE alertas (
    id_alerta INT IDENTITY(1,1) PRIMARY KEY,
    titulo NVARCHAR(150) NOT NULL,
    mensagem NVARCHAR(MAX) NOT NULL,

    severidade NVARCHAR(30) NOT NULL CHECK (
        severidade IN ('informativo', 'atencao', 'alerta', 'emergencia')
    ),

    validade_inicio DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    validade_fim DATETIME2 NOT NULL,

    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),

    criado_por INT NOT NULL,
    ativo BIT NOT NULL DEFAULT 1,
    criado_em DATETIME2 NOT NULL DEFAULT SYSDATETIME(),

    CONSTRAINT fk_alerta_usuario
        FOREIGN KEY (criado_por) REFERENCES usuarios(id_usuario)
);

CREATE TABLE alerta_bairros (
    id_alerta_bairro INT IDENTITY(1,1) PRIMARY KEY,
    id_alerta INT NOT NULL,
    id_bairro INT NOT NULL,

    CONSTRAINT fk_alerta_bairro_alerta
        FOREIGN KEY (id_alerta) REFERENCES alertas(id_alerta),

    CONSTRAINT fk_alerta_bairro_bairro
        FOREIGN KEY (id_bairro) REFERENCES bairros(id_bairro)
);

CREATE TABLE mensagens_chat (
    id_mensagem INT IDENTITY(1,1) PRIMARY KEY,
    id_ocorrencia INT NOT NULL,
    id_remetente INT NOT NULL,
    mensagem NVARCHAR(MAX) NOT NULL,
    lida BIT NOT NULL DEFAULT 0,
    criado_em DATETIME2 NOT NULL DEFAULT SYSDATETIME(),

    CONSTRAINT fk_chat_ocorrencia
        FOREIGN KEY (id_ocorrencia) REFERENCES ocorrencias(id_ocorrencia),

    CONSTRAINT fk_chat_remetente
        FOREIGN KEY (id_remetente) REFERENCES usuarios(id_usuario)
);

CREATE TABLE avaliacoes_atendimento (
    id_avaliacao INT IDENTITY(1,1) PRIMARY KEY,
    id_ocorrencia INT NOT NULL,
    id_usuario INT NOT NULL,
    nota INT NOT NULL CHECK (nota BETWEEN 1 AND 5),
    comentario NVARCHAR(MAX),
    criado_em DATETIME2 NOT NULL DEFAULT SYSDATETIME(),

    CONSTRAINT fk_avaliacao_ocorrencia
        FOREIGN KEY (id_ocorrencia) REFERENCES ocorrencias(id_ocorrencia),

    CONSTRAINT fk_avaliacao_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
