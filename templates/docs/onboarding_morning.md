# Onboarding Matinal — Início de Sessão

> Use como checklist de retomada rápida no início de cada sessão de trabalho.
> [ADAPTÁVEL — ajuste as seções ao fluxo do seu projeto]

---

## 1. Leitura obrigatória

Antes de qualquer ação, leia nesta ordem:

- [ ] `CLAUDE.md` — instruções gerais do projeto
- [ ] `docs/architecture.md` — visão sistêmica e inventário de módulos [ADAPTÁVEL]
- [ ] `.claude/rules/security.md` — fronteiras de segurança operacional

---

## 2. Estado do repositório

```bash
git status
git log --oneline -10
```

Verifique:

- [ ] Branch atual está correta
- [ ] Não há mudanças não commitadas de sessão anterior
- [ ] Não há conflito pendente

---

## 3. Estado do ambiente [ADAPTÁVEL]

Adapte à stack do projeto. Exemplos:

```bash
# Para projetos com banco local:
# [PKG_MANAGER] run db:status

# Para projetos com servidor local:
# [PKG_MANAGER] run dev

# Para projetos com testes:
# [PKG_MANAGER] run test
```

Verifique:

- [ ] Dependências instaladas e atualizadas
- [ ] Variáveis de ambiente carregadas (`.env` presente)
- [ ] Ambiente local funcional

---

## 4. Prioridade da sessão

Antes de começar, confirme:

- [ ] Qual é a tarefa principal desta sessão?
- [ ] Há pendência da sessão anterior? (verifique `docs/changelog_internal.md`)
- [ ] A tarefa requer Plan Mode? (mudanças arquiteturais, multi-arquivo, com risco)

---

## 5. Sinal de alerta

Pare e confirme com o usuário antes de prosseguir se:

- A tarefa toca auth, banco, pagamentos ou módulo compartilhado
- Há divergência entre código e documentação
- A mudança afeta mais de 3 arquivos sem ser um refactor explícito

---

## Ao terminar

Execute `/project:done` ao final de toda sessão com alterações.
