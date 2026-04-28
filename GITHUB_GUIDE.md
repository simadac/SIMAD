# Guia de Colaboração - SIMAD

Este documento define as diretrizes de colaboração no repositório do SIMAD, incluindo padrões de commits, fluxo de trabalho e boas práticas.

---

## 📋 Índice

1. [Fluxo de Trabalho (Git Flow)](#fluxo-de-trabalho-git-flow)
2. [Padrão de Commits](#padrão-de-commits)
3. [Padrão de Branches](#padrão-de-branches)
4. [Pull Requests](#pull-requests)
5. [Code Review](#code-review)
6. [Boas Práticas](#boas-práticas)
7. [Comandos Úteis](#comandos-úteis)

---

## 🌿 Fluxo de Trabalho (Git Flow)

### Branch principal (produção)
- `main` ou `master` - Código em produção (estável)

### Branch de desenvolvimento
- `develop` - Integração das funcionalidades em desenvolvimento

### Branches temporárias

| Tipo | Prefixo | Exemplo | Destino |
|------|---------|---------|---------|
| Funcionalidade | `feature/` | `feature/login-morador` | `develop` |
| Correção de bug | `fix/` | `fix/mapa-nao-carrega` | `develop` |
| Documentação | `docs/` | `docs/api-endpoints` | `develop` |
| Refatoração | `refactor/` | `refactor/css-modular` | `develop` |
| Hotfix (urgente) | `hotfix/` | `hotfix/cors-error` | `main` + `develop` |

---

## 📝 Padrão de Commits

### Formato

```
<tipo>(<escopo>): <descrição curta>

[corpo opcional]

[rodapé opcional]
```

### Tipos de Commit

| Tipo | Emoji | Descrição | Exemplo |
|------|-------|-----------|---------|
| **feat** | ✨ | Nova funcionalidade | `feat(login): adiciona autenticação de morador` |
| **fix** | 🐛 | Correção de bug | `fix(mapa): corrige inicialização do Leaflet` |
| **docs** | 📝 | Documentação | `docs: atualiza README com instruções` |
| **style** | 💄 | Formatação, CSS, estilo | `style: ajusta espaçamentos do header` |
| **refactor** | ♻️ | Refatoração (não altera funcionalidade) | `refactor: extrai funções de mapa para módulo` |
| **test** | ✅ | Testes | `test: adiciona testes para API de ocorrências` |
| **chore** | 🔧 | Tarefas de manutenção | `chore: atualiza dependências` |
| **build** | 📦 | Build, estrutura de pastas | `build: organiza estrutura de CSS` |
| **ci** | ⚙️ | Configuração de CI/CD | `ci: configura GitHub Actions` |
| **perf** | ⚡ | Melhoria de performance | `perf: otimiza carregamento de imagens` |

### Exemplos de Commits

```bash
# Commit simples
git commit -m "feat(morador): permite upload de fotos na ocorrência"

# Commit com escopo
git commit -m "fix(backend): corrige validação de email no cadastro"

# Commit com corpo (mais detalhado)
git commit -m "refactor(maps): refatora inicialização dos mapas

- Adiciona função initMapWithRetry para evitar erros de timing
- Remove código duplicado entre morador e agente
- Padroniza cores dos marcadores"

# Commit de documentação
git commit -m "docs: adiciona guia de colaboração no repositório"
```

---

## 🌿 Padrão de Branches

### Nomenclatura

```bash
feature/nome-da-funcionalidade
fix/descricao-do-bug
docs/o-que-foi-documentado
refactor/o-que-foi-refatorado
hotfix/descricao-do-hotfix
```

### Exemplos

```bash
feature/login-morador
feature/mapa-interativo
fix/erro-no-cadastro
docs/api-endpoints
refactor/css-modular
hotfix/cors-producao
```

---

## 🔀 Pull Requests

### Template de Pull Request

```markdown
## 🎯 Descrição
<!-- Descreva o que este PR faz -->

## 🔗 Issue Relacionada
<!-- Links para issues relacionadas -->
Closes #123

## 📝 Mudanças Propostas
- [ ] Mudança 1
- [ ] Mudança 2

## 🧪 Como Testar
1. Passo 1
2. Passo 2

## 📸 Prints (se aplicável)

## ✅ Checklist
- [ ] Código segue o padrão do projeto
- [ ] Commits seguem o padrão semântico
- [ ] Documentação atualizada
- [ ] Testes passando localmente
```

### Processo de PR

1. **Criar branch** a partir de `develop`
2. **Desenvolver** e fazer commits seguindo o padrão
3. **Push** para o repositório remoto
4. **Abrir Pull Request** para `develop`
5. **Solicitar review** de pelo menos 1 colega
6. **Corrigir** feedbacks
7. **Merge** após aprovação
8. **Deletar** a branch após o merge

---

## 👀 Code Review

### O que revisar

| Critério | O que verificar |
|----------|-----------------|
| **Funcionalidade** | O código faz o que promete? |
| **Qualidade** | Código limpo, legível, sem duplicação |
| **Segurança** | Validação de inputs, proteção contra injeção |
| **Performance** | Sem loops desnecessários, otimizações |
| **Manutenibilidade** | Código fácil de entender e modificar |
| **Documentação** | Comentários quando necessário |

### Como dar feedback

```markdown
✅ **Bom feedback:**
"Ótima implementação! Só sugiro extrair essa função para um arquivo utils."

❌ **Feedback ruim:**
"Isso tá errado."

✅ **Bom feedback:**
"Aqui poderia usar async/await para ficar mais legível."

❌ **Feedback ruim:**
"Reescreve isso."
```

---

## 💡 Boas Práticas

### Commits

- ✅ Commits pequenos e focados
- ✅ Mensagens em português (time brasileiro)
- ❌ Evitar commits gigantes com muitas mudanças

### Branches

- ✅ Manter `develop` sempre funcional
- ✅ Deletar branches após o merge
- ❌ Nunca commitar diretamente em `main` ou `develop`

### Pull Requests

- ✅ Um PR por funcionalidade
- ✅ Descrever bem o que foi feito
- ✅ Adicionar prints quando for UI
- ❌ PRs muito grandes (difíceis de revisar)

---

## 🛠️ Comandos Úteis

### Configuração inicial

```bash
# Clonar o repositório
git clone https://github.com/seu-usuario/simad.git

# Entrar na pasta
cd simad

# Verificar branches
git branch -a
```

### Trabalho diário

```bash
# Atualizar develop
git checkout develop
git pull origin develop

# Criar branch de feature
git checkout -b feature/nova-funcionalidade

# Verificar status
git status

# Adicionar arquivos específicos
git add frontend/js/morador.js

# Adicionar todos os arquivos modificados
git add .

# Commitar
git commit -m "feat(morador): adiciona nova funcionalidade"

# Enviar para o repositório
git push origin feature/nova-funcionalidade

# Voltar para develop
git checkout develop

# Deletar branch local (após merge)
git branch -d feature/nova-funcionalidade

# Deletar branch remota (após merge)
git push origin --delete feature/nova-funcionalidade
```

### Resolução de conflitos

```bash
# Atualizar develop
git checkout develop
git pull origin develop

# Voltar para sua branch
git checkout feature/sua-branch

# Mesclar develop na sua branch
git merge develop

# Resolver conflitos manualmente nos arquivos indicados
# Após resolver, marcar como resolvido
git add arquivo-com-conflito.js

# Finalizar o merge
git commit -m "merge: resolve conflitos com develop"

# Enviar a branch atualizada
git push origin feature/sua-branch
```

---

## 📌 Resumo Rápido

| Situação | Comando |
|----------|---------|
| Criar branch | `git checkout -b feature/nome` |
| Ver status | `git status` |
| Adicionar mudanças | `git add .` |
| Commitar | `git commit -m "feat: mensagem"` |
| Enviar | `git push origin nome-da-branch` |
| Atualizar branch | `git pull origin develop` |

---

## 🚨 Em caso de dúvida

1. Consulte este documento
2. Pergunte no grupo do WhatsApp
3. Abra uma issue no GitHub

---

**SIMAD** — Porque segundos salvam vidas
