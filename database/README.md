# Banco de Dados - SIMAD

Este diretório contém os scripts SQL utilizados para criação e população inicial do banco de dados do SIMAD.

O banco foi configurado no Microsoft Azure, utilizando o serviço **Azure SQL Database**, dentro da assinatura **Azure for Students**.

## Ambiente criado

| Recurso | Nome |
|---|---|
| Grupo de recursos | `rg-simad-dev` |
| Servidor SQL | `sql-simad-dev-2026` |
| Banco de dados | `db-simad-dev` |
| Camada | Free |
| Região | Brazil South |

## Arquivos

| Arquivo | Finalidade |
|---|---|
| `schema.sql` | Criação das tabelas do banco |
| `seeds.sql` | Inserção de dados iniciais para teste |
| `README.md` | Documentação resumida do banco |

## Tabelas criadas

- `usuarios`
- `bairros`
- `tipos_ocorrencia`
- `status_ocorrencia`
- `enderecos_usuario`
- `preferencias_notificacao`
- `ocorrencias`
- `fotos_ocorrencia`
- `historico_ocorrencia`
- `atribuicoes_ocorrencia`
- `alertas`
- `alerta_bairros`
- `mensagens_chat`
- `avaliacoes_atendimento`

## Objetivo da modelagem

A modelagem foi construída para atender às principais funcionalidades do SIMAD:

- cadastro de moradores, agentes e administradores;
- registro de ocorrências com endereço e geolocalização;
- armazenamento de fotos por ocorrência;
- acompanhamento do status da ocorrência;
- histórico de atualizações;
- emissão de alertas por bairro;
- comunicação por chat;
- avaliação do atendimento.

## Observação de segurança

Este repositório não deve conter senhas, strings de conexão, credenciais do Azure ou chaves privadas.
