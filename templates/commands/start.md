<!--
  COMANDO: /project:start
  QUANDO ACIONAR: automaticamente ao iniciar qualquer sessão (ver CLAUDE.md).
  QUEM ACIONA: Claude automaticamente na primeira mensagem | usuário explicitamente.
  ETAPAS: [GENÉRICO]
  1. Onboarding     — leitura obrigatória, estado do repo e ambiente
  2. Security       — checklist diário de segurança
  3. README         — verificação de completude e placeholders
  4. Business       — contexto de negócio e pendências da sessão anterior
  5. Relatório      — sumário consolidado e gravação de log
-->

# /project:start

Rotina de início de sessão. Executada automaticamente antes de qualquer trabalho.

Execute todas as etapas em sequência. Não pule nenhuma.

---

## 1. Onboarding — Leitura e Estado

### 1.1 Leitura obrigatória

Leia nesta ordem:

- `CLAUDE.md` completo
- Arquivos listados em "Leitura Obrigatória" do CLAUDE.md

### 1.2 Estado do repositório

Execute em paralelo:

```bash
git status
git log --oneline -10
git stash list
```

Verifique:

- [ ] Branch atual está correta para a sessão
- [ ] Não há mudanças não commitadas de sessão anterior sem justificativa
- [ ] Não há conflito pendente
- [ ] Stash list está vazio ou os itens são conhecidos

### 1.3 Estado do ambiente [ADAPTÁVEL]

- [ ] Dependências instaladas (`bun install` / `npm install` se necessário)
- [ ] Variáveis de ambiente carregadas (`.env` presente e não vazio)
- [ ] Migrations pendentes não aplicadas — verificar se aplicável
- [ ] Erros críticos nos logs desde a última sessão — verificar se aplicável

---

## 2. Security — Checklist Diário

Execute esta verificação rápida de segurança antes de qualquer implementação.
Para auditoria completa, use a skill `/security-audit`.

### Variáveis de ambiente

- [ ] Nenhum secret em variáveis `VITE_` ou equivalentes públicos
- [ ] Variáveis públicas limitadas ao que o frontend realmente precisa
- [ ] Secrets de backend presentes apenas em ambiente seguro

### Acesso a dados [ADAPTÁVEL]

- [ ] Toda tabela nova tem controle de acesso habilitado (RLS ou equivalente)
- [ ] Nenhuma query multi-tenant depende apenas do frontend para filtragem
- [ ] Inputs externos continuam validados

### Autenticação

- [ ] Confirmação de e-mail habilitada em produção (se aplicável)
- [ ] URLs de callback e redirect estão na allowlist correta
- [ ] Logout invalida sessão corretamente

### Dependências

- [ ] Sem vulnerabilidades críticas conhecidas nas dependências principais
- [ ] Nenhum pacote crítico desatualizado com impacto de segurança conhecido

> Se algum item falhar: **PARE** e reporte antes de prosseguir.

---

## 3. README — Verificação de Completude

Leia o `README.md` do projeto e verifique:

- [ ] Não há placeholders não preenchidos (`[definir]`, `TODO`, `???`, `[NOME DO PROJETO]`, etc.)
- [ ] Seção de instalação/uso existe e está atualizada com a stack atual
- [ ] Seção de pré-requisitos reflete as versões reais em uso
- [ ] Links internos e externos estão funcionais (verificar ao menos os principais)
- [ ] Descrição do produto condiz com o que o projeto faz hoje

Se encontrar placeholders ou seções desatualizadas:

1. Liste os itens encontrados no relatório final desta sessão
2. **Não corrija automaticamente** — registre como pendência para o usuário decidir

---

## 4. Business — Contexto e Pendências

### 4.1 Últimas sessões

Leia as 3 entradas mais recentes de `docs/changelog_internal.md`.

Identifique:

- O que foi implementado recentemente
- Se há itens marcados como pendentes ou incompletos
- Se há decisões técnicas recentes relevantes para a sessão atual

### 4.2 Prioridade da sessão

Antes de concluir o start, confirme:

- [ ] Qual é a tarefa principal desta sessão?
- [ ] Há pendência da sessão anterior que precisa ser resolvida primeiro?
- [ ] A tarefa requer Plan Mode? (mudanças arquiteturais, multi-arquivo, com risco)

---

## 5. Relatório Consolidado

Apresente no chat um resumo com:

```markdown
## Estado da Sessão — [YYYY-MM-DD HH:mm]

### Onboarding
- Branch: [branch atual]
- Mudanças pendentes: [sim/não — detalhe se sim]
- Ambiente: [ok | problemas encontrados]

### Security
- Status: [✅ todos ok | ⚠️ itens atenção | ❌ bloqueante]
- Itens com atenção: [listar se houver]

### README
- Status: [✅ completo | ⚠️ placeholders encontrados]
- Pendências: [listar se houver]

### Business
- Última sessão: [resumo de 1 linha]
- Pendências anteriores: [listar se houver]
- Tarefa desta sessão: [aguardando input do usuário]

---
Contexto carregado. Pronto para trabalhar.
```

Grave o log em `logs/start/start-[YYYY-MM-DD_HH-mm].md`.

Só então aguarde instruções do usuário.
