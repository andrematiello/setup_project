<!--
  COMANDO: /project:release [versão]  ex: /project:release 1.2.0
  QUANDO ACIONAR: ao publicar versão formal (Semantic Versioning: MAJOR.MINOR.PATCH).
  QUEM ACIONA: usuário explicitamente.
  ETAPAS: [ADAPTÁVEL]
  1. Revisão → git log desde a última tag, agrupa por tipo
  2. Gate → chama /project:deploy-check; bloqueia se houver pendências
  3. Bump → atualiza versão em package.json
  4. Tag → commit + tag vX.Y.Z + push
  5. Changelog → entrada formal em docs/changelog_internal.md
  6. Deploy → comando de deploy do projeto
  7. Relatório → resumo com hash, tag, changelog e status
-->

# /project:release

Versioning, tag git, changelog formal e deploy de release.

**Uso:** `/project:release [versão]`

**Exemplos:**

- `/project:release 1.2.0`
- `/project:release 1.2.1` (patch de correção)

Siga [Semantic Versioning](https://semver.org/): `MAJOR.MINOR.PATCH`

| Tipo de mudança | Versão |
| --- | --- |
| Correção de bug sem impacto em contratos | PATCH |
| Nova feature sem breaking change | MINOR |
| Breaking change em API, schema ou contrato | MAJOR |

---

## Fase 1 — Revisão do que vai no release [GENÉRICO]

```bash
git log --oneline [última-tag]..HEAD
```

Agrupe as mudanças por tipo:

- **Novidades** (feat)
- **Correções** (fix)
- **Melhorias** (refactor, style, chore)
- **Segurança** (security)
- **Infraestrutura** (docs, test, config)

---

## Fase 2 — Verificação pré-release [GENÉRICO]

Execute `/project:deploy-check` e confirme que está tudo OK antes de prosseguir.

Se houver itens pendentes, resolver antes do release.

---

## Fase 3 — Bump de versão [GENÉRICO]

```bash
# verificar versão atual
cat package.json | grep '"version"'
```

Editar `package.json` com a nova versão.

---

## Fase 4 — Tag git [GENÉRICO]

```bash
git add package.json
git commit -m "chore(release): bump versão para [versão]

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>"

git tag -a v[versão] -m "Release v[versão]"
git push origin main
git push origin v[versão]
```

---

## Fase 5 — Changelog formal [ADAPTÁVEL]

Adicionar entrada em `docs/changelog_internal.md`:

```markdown
## v[versão] — YYYY-MM-DD

### Novidades
- [feat] descrição

### Correções
- [fix] descrição

### Melhorias
- [chore/refactor] descrição

### Segurança
- [security] descrição (se houver)
```

---

## Fase 6 — Deploy de produção [ADAPTÁVEL]

Substitua pelo comando de deploy do projeto:

```bash
# Exemplo: bash scripts/deploy.sh
# Exemplo: [PKG_MANAGER] run deploy
```

---

## Fase 7 — Relatório de release [GENÉRICO]

```text
Release v[versão] — [data]

✅ Versão bumped em package.json
✅ Commit de release: [hash]
✅ Tag criada: v[versão]
✅ Push: origin/main + tag
✅ Changelog atualizado
✅ Deploy produção: OK

Mudanças neste release:
[resumo das mudanças agrupadas]
```
