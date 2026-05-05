-- ============================================================
-- SIMAD — Sistema Integrado de Monitoramento e Alerta de Desastres
-- Script de criação do banco de dados
-- ============================================================

CREATE DATABASE IF NOT EXISTS simad CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE simad;

CREATE TABLE IF NOT EXISTS usuarios (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(150)    NOT NULL,
    email           VARCHAR(150)    NOT NULL UNIQUE,
    senha_hash      VARCHAR(255)    NOT NULL,
    tipo_usuario    ENUM('morador', 'agente') NOT NULL DEFAULT 'morador',
    telefone        VARCHAR(20),
    data_criacao    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_tipo_usuario (tipo_usuario)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ocorrencias (
    id                      INT AUTO_INCREMENT PRIMARY KEY,
    titulo                  VARCHAR(200)    NOT NULL,
    tipo_ocorrencia         VARCHAR(100)    NOT NULL DEFAULT 'Geral',
    descricao               TEXT            NOT NULL,
    cep                     VARCHAR(10),
    endereco                VARCHAR(255),
    bairro                  VARCHAR(100),
    cidade                  VARCHAR(100),
    estado                  VARCHAR(50),
    latitude                DECIMAL(10, 7),
    longitude               DECIMAL(10, 7),
    status                  ENUM('pendente','em_andamento','aprovado','resolvido','rejeitado')
                            NOT NULL DEFAULT 'pendente',
    urgencia                ENUM('baixo','medio','alto','critico') DEFAULT 'medio',
    id_morador              INT             NOT NULL,
    id_agente_responsavel   INT,
    observacao_agente       TEXT,
    comentario_interno      TEXT,
    equipe                  VARCHAR(100),
    data_criacao            DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao        DATETIME        NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_morador)            REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (id_agente_responsavel) REFERENCES usuarios(id) ON DELETE SET NULL,
    INDEX idx_status         (status),
    INDEX idx_tipo           (tipo_ocorrencia),
    INDEX idx_bairro         (bairro),
    INDEX idx_data_criacao   (data_criacao),
    INDEX idx_morador        (id_morador)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS fotos_ocorrencia (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    id_ocorrencia   INT             NOT NULL,
    -- LONGTEXT permite salvar Base64 no MVP.
    -- Em produção, prefira salvar o arquivo em pasta/storage e guardar aqui apenas o caminho.
    caminho_foto    LONGTEXT        NOT NULL,
    data_upload     DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_ocorrencia) REFERENCES ocorrencias(id) ON DELETE CASCADE,
    INDEX idx_ocorrencia (id_ocorrencia)
) ENGINE=InnoDB;

INSERT INTO usuarios (nome, email, senha_hash, tipo_usuario, telefone) VALUES
  ('João Silva', 'morador@teste.com', '$2b$12$HASH_PLACEHOLDER', 'morador', '(11) 99999-1111'),
  ('Maria Santos', 'morador2@teste.com', '$2b$12$HASH_PLACEHOLDER', 'morador', '(11) 99999-2222'),
  ('Carlos Pereira', 'agente@defesacivil.com', '$2b$12$HASH_PLACEHOLDER', 'agente', '(11) 97777-7777')
ON DUPLICATE KEY UPDATE nome = VALUES(nome);
