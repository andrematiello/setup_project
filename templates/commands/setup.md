<!--
  COMANDO: /project:setup
  QUANDO ACIONAR: uma vez, logo após instalar o claude-kit em um projeto novo.
  QUEM ACIONA: usuário explicitamente.
  ETAPAS:
  - Lê contexto do projeto (package.json, estrutura, lockfile, configs)
  - Detecta stack, deploy, gerenciador de pacotes e serviços externos
  - Gera rascunho de CLAUDE.md adaptado ao projeto
  - Apresenta rascunho no chat e aguarda aprovação
  - Salva CLAUDE.md na raiz após aprovação
-->

# /project:setup

Configuração inicial do ambiente Claude Code para este projeto.
Execute uma vez, logo após instalar o claude-kit.

---

## Sequência obrigatória

### 1. Leitura do contexto do projeto

Leia os seguintes arquivos **se existirem**:

- `package.json` → nome, scripts, dependências
- `bun.lockb` / `package-lock.json` / `pnpm-lock.yaml` / `yarn.lock` → gerenciador de pacotes
- `wrangler.jsonc` / `wrangler.toml` → Cloudflare
- `vercel.json` / `.vercel/` → Vercel
- `netlify.toml` → Netlify
- `Dockerfile` / `docker-compose.yml` → containers
- `tsconfig.json` → TypeScript
- `vite.config.*` / `next.config.*` / `nuxt.config.*` → framework frontend
- `supabase/config.toml` → Supabase
- `prisma/schema.prisma` → Prisma
- `drizzle.config.*` → Drizzle
- `.env.example` → variáveis de ambiente disponíveis
- Estrutura de `src/` / `app/` / `lib/`

### 2. Inferência do perfil do projeto

Determine com base na leitura:

| Item | Como detectar |
| --- | --- |
| Nome | `package.json` → `name` |
| Tipo | SaaS / API / mobile / CLI / library / monorepo |
| Framework frontend | React / Next.js / Vue / Nuxt / Svelte / nenhum |
| Backend / banco | Supabase / Prisma / Drizzle / outro / nenhum |
| Deploy | Cloudflare / Vercel / Netlify / Railway / Docker / outro |
| Gerenciador de pacotes | bun / npm / pnpm / yarn |
| TypeScript | sim / não |
| Multi-tenancy | verificar `org_id` / `tenant_id` / `workspace_id` no código |
| Autenticação | Supabase Auth / NextAuth / Clerk / Auth.js / custom |
| Pagamentos | Stripe / Paddle / LemonSqueezy / nenhum |
| Idioma da UX | detectar em strings do código ou perguntar |

Se não conseguir inferir um item com confiança: **pergunte antes de assumir**.

### 3. Geração do rascunho de CLAUDE.md

Gere o CLAUDE.md completo seguindo a estrutura do template em `CLAUDE.md` (raiz),
substituindo todos os placeholders `[MAIÚSCULAS]` pelos valores detectados.

Regras de escrita obrigatórias:

- Use imperativo direto: "Nunca faça X" e não "É recomendado evitar X"
- Separe o que é invariante (nunca/sempre) do que é preferência (prefira/evite)
- Inclua apenas seções com conteúdo real — omita as que não se aplicam
- Seção de comportamento deve ter gatilhos específicos, não intenções vagas
- O documento inteiro deve caber em menos de 200 linhas

### 4. Apresentação e aprovação

Apresente o rascunho completo no chat e pergunte:

> "Este é o rascunho do CLAUDE.md adaptado para este projeto.
> Revise e me diga o que está incorreto ou faltando. Posso salvar?"

**Não salve antes da aprovação explícita.**

### 5. Salvar e reportar

Após aprovação:

1. Salve o conteúdo em `CLAUDE.md` na raiz do projeto
2. Reporte:

```
✅ CLAUDE.md salvo.

Próximos passos recomendados:
- Revise .claude/commands/ — os comandos estão em versão genérica,
  adapte os [PLACEHOLDERS] conforme seu projeto
- Adicione .claude/rules/ com regras detalhadas dos domínios
- Execute /project:start para verificar o estado inicial
```
