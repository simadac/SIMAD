# Modelagem do Banco de Dados - SIMAD

## 1. Visão geral

O SIMAD, Sistema Integrado de Monitoramento e Alerta de Desastres, utiliza um banco de dados relacional para armazenar informações relacionadas a usuários, ocorrências, alertas, bairros, histórico de atendimento, mensagens e avaliações.

A modelagem foi desenvolvida com foco no funcionamento do MVP do sistema, permitindo que moradores registrem ocorrências e que agentes da Defesa Civil acompanhem, atualizem e gerenciem essas solicitações.

## 2. Tecnologia utilizada

| Item | Definição |
|---|---|
| Banco de dados | Azure SQL Database |
| Servidor | `sql-simad-dev-2026` |
| Banco | `db-simad-dev` |
| Ambiente | Desenvolvimento |
| Assinatura | Azure for Students |
| Região | Brazil South |

## 3. Entidades principais

A modelagem do banco foi organizada em módulos.

### 3.1 Usuários

Tabelas:

- `usuarios`
- `enderecos_usuario`
- `preferencias_notificacao`

Essas tabelas armazenam dados dos moradores, agentes e administradores, além de endereço e preferências de notificação.

### 3.2 Ocorrências

Tabelas:

- `ocorrencias`
- `tipos_ocorrencia`
- `status_ocorrencia`
- `fotos_ocorrencia`
- `historico_ocorrencia`
- `atribuicoes_ocorrencia`

Essas tabelas permitem registrar ocorrências, classificar o tipo, acompanhar o status, armazenar fotos, registrar atualizações e designar responsáveis.

### 3.3 Alertas

Tabelas:

- `alertas`
- `alerta_bairros`
- `bairros`

Essas tabelas permitem emitir alertas vinculados a bairros específicos e controlar sua severidade e validade.

### 3.4 Comunicação e avaliação

Tabelas:

- `mensagens_chat`
- `avaliacoes_atendimento`

Essas tabelas permitem comunicação entre morador e Defesa Civil e avaliação do atendimento após a resolução da ocorrência.

## 4. Tabelas do banco

| Tabela | Finalidade |
|---|---|
| `usuarios` | Armazena moradores, agentes e administradores |
| `bairros` | Padroniza os bairros usados no sistema |
| `tipos_ocorrencia` | Define as categorias das ocorrências |
| `status_ocorrencia` | Define os estados possíveis de uma ocorrência |
| `enderecos_usuario` | Armazena endereço dos usuários |
| `preferencias_notificacao` | Registra preferências de recebimento de alertas |
| `ocorrencias` | Tabela principal de chamados/ocorrências |
| `fotos_ocorrencia` | Armazena URLs ou caminhos de fotos das ocorrências |
| `historico_ocorrencia` | Registra alterações e movimentações da ocorrência |
| `atribuicoes_ocorrencia` | Registra agentes responsáveis por ocorrências |
| `alertas` | Armazena alertas emitidos pela Defesa Civil |
| `alerta_bairros` | Relaciona alertas com bairros afetados |
| `mensagens_chat` | Armazena mensagens vinculadas a ocorrências |
| `avaliacoes_atendimento` | Registra feedback do morador sobre o atendimento |

## 5. Relacionamentos principais

```text
usuarios 1:N ocorrencias
usuarios 1:N enderecos_usuario
usuarios 1:N preferencias_notificacao
usuarios 1:N historico_ocorrencia
usuarios 1:N mensagens_chat
usuarios 1:N avaliacoes_atendimento

bairros 1:N ocorrencias
bairros 1:N alerta_bairros

tipos_ocorrencia 1:N ocorrencias

status_ocorrencia 1:N ocorrencias
status_ocorrencia 1:N historico_ocorrencia

ocorrencias 1:N fotos_ocorrencia
ocorrencias 1:N historico_ocorrencia
ocorrencias 1:N atribuicoes_ocorrencia
ocorrencias 1:N mensagens_chat
ocorrencias 1:1 avaliacoes_atendimento

alertas 1:N alerta_bairros
```

## 6. Justificativa da modelagem

A modelagem relacional foi escolhida porque o SIMAD trabalha com entidades bem definidas e com relações diretas entre usuários, ocorrências, bairros, alertas e status.

A separação das informações em tabelas específicas evita duplicidade, melhora a integridade dos dados e facilita consultas para dashboards, mapas, relatórios e acompanhamento das ocorrências.

## 7. Dados iniciais

Foram inseridos dados iniciais para validação:

- bairros de teste;
- tipos de ocorrência;
- status de ocorrência;
- usuários de teste;
- uma ocorrência de teste.

Esses dados permitem validar o funcionamento dos relacionamentos entre as tabelas.

## 8. Validação realizada

Após a criação das tabelas, foi executada uma consulta relacionando:

- ocorrência;
- morador;
- tipo de ocorrência;
- status;
- bairro.

A consulta retornou corretamente os dados da ocorrência de teste, demonstrando que os principais relacionamentos do banco estão funcionando.

## 9. Segurança

O repositório não deve armazenar:

- senhas do banco;
- strings de conexão reais;
- chaves secretas;
- credenciais do Azure.

Essas informações devem ser armazenadas em variáveis de ambiente ou nas configurações seguras do Azure App Service.
