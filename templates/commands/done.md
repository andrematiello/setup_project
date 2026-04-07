<!--
  COMANDO: /project:done
  QUANDO ACIONAR: fim de toda sessão com alteração em código, banco ou arquivos.
  Não se aplica a sessões apenas de consulta.
  Chamado automaticamente pelo /project:deploy-check (Fase 1) quando tudo ✅.
  ETAPAS: [ADAPTÁVEL]
  1. Changelog → registra em docs/changelog_internal.md
  2. Documentação → valida e atualiza docs afetados
  3. Commit → Conventional Commits
  4. Push → aciona deploy automático (verificar se aplica ao projeto)
  5. Deploy backend/migrations → quando aplicável
  6. Relatório → grava logs/done/done-[data].md
-->

# /project:done

Rotina de encerramento de sessão. Execute ao final de toda implementação.

**Não se aplica a sessões apenas de consulta ou respostas sem modificação.**

---

## Protocolo Operacional — Sequência Obrigatória

### 1. Changelog [ADAPTÁVEL]

Verifique o que foi implementado nesta sessão.

**Arquivo:** `docs/changelog_internal.md`

Adicione uma nova entrada com:

- Data e hora
- Resumo objetivo das mudanças
- Arquivos modificados
- Tipo de alteração
- Texto do commit proposto
- Assinatura do agente

```markdown
## YYYY-MM-DD: tipo(escopo): descrição breve

**Resumo:**
[descrição clara do que foi feito e por quê]

**Arquivos Modificados:**
- `caminho/arquivo` — descrição da mudança (Tipo)

**Tipo:** [Nova Funcionalidade | Correção | Refatoração | Documentação | Segurança]

**Commit:** `hash` — tipo(escopo): mensagem

**Agente:** Claude Sonnet 4.6

###################
```

---

### 2. Documentação [ADAPTÁVEL]

Para cada mudança implementada, validar se a documentação foi atualizada.

- [ ] `docs/architecture.md`
- [ ] `docs/features.md`
- [ ] `docs/data-flow.md`
- [ ] `docs/infrastructure.md`
- [ ] Regras de negócio afetadas
- [ ] Fluxos do sistema afetados

**Não faça commit com documentação defasada.**

---

### 3. Commit [GENÉRICO]

```bash
git add .
git commit -m "tipo(escopo): descrição curta

Detalhamento opcional.

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>"
```

Tipos: `feat` | `fix` | `refactor` | `docs` | `style` | `test` | `chore`

---

### 4. Push [ADAPTÁVEL]

> **Atenção:** verifique se o push aciona deploy automático no seu projeto.
>
> Execute `/project:deploy-check` antes do push quando a sessão envolver:
>
> - Migration nova ou alterada
> - Serviço de backend novo ou modificado
> - Variável de ambiente adicionada ou renomeada
> - Qualquer mudança em auth, políticas de acesso ou pagamentos
> - Feature com acesso a dados ou query multi-tenant
> - Refactor de módulo compartilhado
> - Release planejada
>
> Push direto é seguro para: docs, style, chore, novos testes unitários.

```bash
git push origin main
# ou: git push origin [branch-atual]
```

---

### 5. Deploy de backend / migrations (quando aplicável) [ADAPTÁVEL]

Substitua pelos comandos do seu projeto:

```bash
# Exemplo: supabase functions deploy nome-da-funcao
# Exemplo: [PKG_MANAGER] run db:migrate
```

---

### 6. Relatório final [ADAPTÁVEL]

Salve em `logs/done/done-[YYYY-MM-DD_HH-mm].md`:

```markdown
## Relatório de Execução

Data: [YYYY-MM-DD HH:mm]

### Resumo
- [o que foi feito]
- [arquivos alterados]
- [tipo de alteração]

### Status
✅ Changelog atualizado
✅ Documentação validada
✅ Commit: [hash] - [mensagem]
✅ Push: origin/[branch]
✅ Deploy backend: [ok | não aplicável]
✅ Deploy migrations: [ok | não aplicável]
```
