<div align="center">

# 🚨 SIMAD - Sistema Integrado de Monitoramento e Alerta de Desastres

![Versão](https://img.shields.io/badge/version-1.0.0-blue)
![Status](https://img.shields.io/badge/status-em%20desenvolvimento-green)
![Licença](https://img.shields.io/badge/license-MIT-purple)
![Frontend](https://img.shields.io/badge/frontend-HTML%2FCSS%2FJS-orange)
![Backend](https://img.shields.io/badge/backend-Python%2FFastAPI-blue)

**"Porque segundos salvam vidas"**

[Sobre](#-sobre-o-projeto) •
[Funcionalidades](#-funcionalidades) •
[Tecnologias](#-tecnologias) •
[Como Executar](#-como-executar) •
[Equipe](#-equipe)

</div>

---

## 📖 Sobre o Projeto

O **SIMAD (Sistema Integrado de Monitoramento e Alerta de Desastres)** é uma plataforma desenvolvida para a **Defesa Civil de Campo Limpo Paulista - SP**, com o objetivo de criar um canal direto de comunicação entre os cidadãos e a Defesa Civil, permitindo o monitoramento em tempo real, emissão de alertas e gestão eficiente de ocorrências.

### 🎯 Problema que resolvemos

- **Comunicação lenta** entre população e Defesa Civil
- **Falta de informação** sobre riscos e alertas na região
- **Dificuldade no acompanhamento** de ocorrências reportadas
- **Ausência de dados consolidados** para tomada de decisão

### ✨ Nossa Solução

Uma plataforma integrada que conecta moradores e agentes da Defesa Civil, oferecendo:

- ✅ Reporte rápido de ocorrências com fotos e geolocalização
- ✅ Alertas em tempo real para áreas de risco
- ✅ Acompanhamento transparente do status das ocorrências
- ✅ Dashboard com gráficos e mapas para gestão estratégica
- ✅ Comunicação direta via chat e canais oficiais

---

## 🚀 Funcionalidades

### 👤 Para Moradores

| Funcionalidade | Descrição |
|----------------|-----------|
| **Cadastro e Login** | Criação de conta com dados pessoais e endereço |
| **Dashboard** | Visão geral com alertas ativos e ocorrências recentes |
| **Nova Ocorrência** | Registro com título, descrição, fotos, endereço e nível de urgência |
| **Minhas Ocorrências** | Histórico completo com status e atualizações da Defesa Civil |
| **Mapa de Alertas** | Visualização interativa de alertas na região |
| **Perfil** | Edição de dados cadastrais e preferências de notificação |
| **Avaliação** | Feedback sobre atendimento após resolução da ocorrência |

### 👮 Para Agentes da Defesa Civil

| Funcionalidade | Descrição |
|----------------|-----------|
| **Dashboard** | KPIs, gráficos e mapa de ocorrências |
| **Gestão de Chamados** | Aprovação/rejeição de solicitações dos moradores |
| **Atualização de Status** | Acompanhamento do progresso das ocorrências |
| **Emissão de Alertas** | Criação de alertas com seleção de bairros, severidade e validade |
| **Relatórios** | Exportação de dados em CSV e PDF |
| **Designação de Equipe** | Atribuição de responsáveis por ocorrência |
| **Mapa Estratégico** | Visualização completa de todas ocorrências e alertas ativos |

---

## 🛠️ Tecnologias

### Frontend

| Tecnologia | Finalidade |
|------------|------------|
| **HTML5** | Estrutura das páginas |
| **CSS3** | Estilização com design responsivo |
| **JavaScript (Vanilla)** | Interatividade e lógica do frontend |
| **Leaflet** | Mapas interativos |
| **Chart.js** | Gráficos e analytics |
| **Google Fonts** | Tipografia Plus Jakarta Sans |

### Backend (em desenvolvimento)

| Tecnologia | Finalidade |
|------------|------------|
| **Python 3.11+** | Linguagem principal |
| **FastAPI** | Framework para API REST |
| **Azure SQL** | Banco de dados relacional |
| **SQLAlchemy** | ORM para acesso a dados |
| **JWT** | Autenticação e autorização |
| **Pydantic** | Validação de dados |

### Infraestrutura

| Tecnologia | Finalidade |
|------------|------------|
| **Azure App Service** | Hospedagem do backend |
| **Azure Static Web Apps** | Hospedagem do frontend |
| **Azure Blob Storage** | Armazenamento de imagens |
| **GitHub Actions** | CI/CD automatizado |

---

## 📁 Estrutura do Projeto

```
simad/
│
├── frontend/                    # Interface do usuário
│   ├── index.html              # Landing page
│   ├── login.html              # Página de login/cadastro
│   ├── morador.html            # Dashboard do morador
│   ├── agente.html             # Dashboard do agente
│   │
│   ├── css/
│   │   ├── main.css            # Variáveis e base
│   │   ├── components.css      # Componentes reutilizáveis
│   │   ├── pages.css           # Estilos por página
│   │   └── responsive.css      # Media queries
│   │
│   ├── js/
│   │   ├── main.js             # Inicialização global
│   │   ├── auth.js             # Autenticação
│   │   ├── morador.js          # Funções do morador
│   │   ├── agente.js           # Funções do agente
│   │   ├── maps.js             # Configuração de mapas
│   │   ├── utils.js            # Utilitários
│   │   ├── mock-data.js        # Dados mockados
│   │   └── validations.js      # Validações
│   │
│   ├── templates/
│   │   ├── partials/
│   │   │   ├── header.html
│   │   │   └── footer.html
│   │   └── modals/
│   │       ├── confirm-modal.html
│   │       ├── perfil-modal.html
│   │       ├── alerta-modal.html
│   │       └── update-occurrence-modal.html
│   │
│   └── assets/
│       └── images/
│           └── favicon_io/
│
├── backend/                     # API e lógica de negócio (em desenvolvimento)
│   ├── app/
│   │   ├── api/
│   │   ├── models/
│   │   ├── schemas/
│   │   └── services/
│   ├── requirements.txt
│   └── .env.example
│
├── database/                    # Scripts do banco de dados
│   ├── migrations/
│   ├── seeds/
│   └── schema.sql
│
├── docs/                        # Documentação
│   ├── API_DOCUMENTATION.md
│   ├── DATABASE_SCHEMA.md
│   └── GITHUB_GUIDE.md
│
└── README.md                    # Este arquivo
```

---

## 💻 Como Executar

### Pré-requisitos

- Navegador web moderno (Chrome, Firefox, Edge)
- (Opcional) Servidor HTTP local para testes

### Executando o Frontend

#### Opção 1 - Direto no navegador
```bash
1. Clone o repositório
2. Navegue até a pasta frontend/
3. Abra o arquivo index.html no navegador
```

#### Opção 2 - Com servidor HTTP local (recomendado)
```bash
# Navegue até a pasta do frontend
cd frontend

# Python 3
python -m http.server 3000

# Ou com Node.js (se tiver)
npx serve .

# Acesse no navegador
http://localhost:3000
```

### Credenciais de Teste

| Tipo | E-mail | Senha |
|------|--------|-------|
| **Morador** | joao@email.com | 123456 |
| **Morador** | maria@email.com | 123456 |
| **Agente** | agente@defesacivil.com | admin123 |

### Configurando o Backend (em desenvolvimento)

```bash
# Criar ambiente virtual
python -m venv venv

# Ativar ambiente virtual
# Windows:
venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate

# Instalar dependências
pip install -r backend/requirements.txt

# Configurar variáveis de ambiente
cp backend/.env.example backend/.env
# Editar .env com suas credenciais

# Executar o servidor
cd backend
uvicorn app.main:app --reload --port 8000
```

---

## 🎨 Cores e Identidade Visual

| Cor | Código | Uso |
|-----|--------|-----|
| Roxo | `#6B46C1` | Botões principais, cabeçalhos, elementos de destaque |
| Azul | `#2B6CB0` | Links, elementos secundários |
| Laranja | `#DD6B20` | Alertas, botões de ação urgente |
| Verde | `#38A169` | Status "resolvido", sucesso |
| Vermelho | `#E53E3E` | Status "rejeitado", erros |

### Tipografia

- **Títulos:** Montserrat (600, 700, 800)
- **Corpo:** Open Sans (400, 500, 600)
- **Dados:** Roboto Mono (monospace)

---

## 📱 Responsividade

O sistema é totalmente responsivo e funciona em:

| Dispositivo | Resolução | Layout |
|-------------|-----------|--------|
| **Mobile** | até 480px | Coluna única, menu adaptado |
| **Tablet** | 768px - 1024px | Grid de 2 colunas |
| **Desktop** | acima de 1024px | Grid de 3-4 colunas |
| **Grande** | acima de 1400px | Espaçamento otimizado |
| **4K** | acima de 1920px | Mapas e gráficos ampliados |

---

## 🤝 Como Contribuir

1. **Faça um fork** do projeto
2. **Crie uma branch** para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. **Commit suas mudanças** seguindo o padrão semântico (`git commit -m "feat: adiciona nova funcionalidade"`)
4. **Push para a branch** (`git push origin feature/nova-funcionalidade`)
5. **Abra um Pull Request**

Consulte o [GUIA DE COLABORAÇÃO](docs/GITHUB_GUIDE.md) para mais detalhes.

### Padrão de Commits

```bash
feat: nova funcionalidade
fix: correção de bug
docs: documentação
style: formatação
refactor: refatoração
test: testes
chore: manutenção
```

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 👥 Equipe

| Membro | Função | Contato |
|--------|--------|---------|
| **Frontend** | Desenvolvimento da interface | [GitHub](https://github.com/) |
| **Backend** | API e lógica de negócio | [GitHub](https://github.com/) |
| **Banco de Dados** | Modelagem e queries | [GitHub](https://github.com/) |
| **DevOps** | Infraestrutura e deploy | [GitHub](https://github.com/) |

---

## 📞 Contato

- **Defesa Civil - Emergência:** 199
- **E-mail:** simadac@outlook.com
---

<div align="center">

*"Porque segundos salvam vidas"*

</div>
