<!--
  COMANDO: /project:setup
  QUANDO ACIONAR: uma vez, logo após instalar o claude-kit em um projeto novo.
  QUEM ACIONA: usuário explicitamente.
  ETAPAS:
  - Fase 1: lê e analisa o projeto automaticamente
  - Fase 2: entrevista o usuário sobre o que não pode ser inferido
  - Fase 3: gera rascunho completo de CLAUDE.md e aguarda aprovação
  - Fase 4: salva CLAUDE.md e reporta próximos passos
-->

# /project:setup

Configuração inicial do ambiente Claude Code para este projeto.
Execute uma vez, logo após instalar o claude-kit.

---

## Fase 1 — Análise automática do projeto

Leia os seguintes arquivos **se existirem** e extraia as informações indicadas:

| Arquivo | O que extrair |
| --- | --- |
| `package.json` | nome do projeto, scripts disponíveis, dependências principais |
| `bun.lockb` / `package-lock.json` / `pnpm-lock.yaml` / `yarn.lock` | gerenciador de pacotes |
| `tsconfig.json` | se usa TypeScript e configurações relevantes |
| `vite.config.*` / `next.config.*` / `nuxt.config.*` / `astro.config.*` | framework frontend |
| `wrangler.jsonc` / `wrangler.toml` | deploy via Cloudflare Workers/Pages |
| `vercel.json` / `.vercel/` | deploy via Vercel |
| `netlify.toml` | deploy via Netlify |
| `railway.json` / `render.yaml` | deploy via Railway ou Render |
| `Dockerfile` / `docker-compose.yml` | containerização |
| `supabase/config.toml` | Supabase (banco, auth, Edge Functions) |
| `prisma/schema.prisma` | Prisma ORM |
| `drizzle.config.*` | Drizzle ORM |
| `.env.example` / `.env.local.example` | variáveis de ambiente disponíveis |
| Estrutura de `src/` / `app/` / `lib/` / `packages/` | organização do código |

**Infira automaticamente:**

| Item | Como detectar |
| --- | --- |
| Nome do projeto | `package.json` → `name` |
| Tipo de produto | SaaS / API / mobile / CLI / library / monorepo / landing |
| Framework frontend | React / Next.js / Vue / Nuxt / Svelte / nenhum |
| Backend / banco | Supabase / Prisma / Drizzle / outro / nenhum |
| Deploy | plataforma e branch que aciona produção |
| Gerenciador de pacotes | bun / npm / pnpm / yarn |
| TypeScript | sim / não |
| Multi-tenancy | verificar `org_id` / `tenant_id` / `workspace_id` no código |
| Autenticação | Supabase Auth / NextAuth / Clerk / Auth.js / custom / nenhum |
| Pagamentos | Stripe / Paddle / LemonSqueezy / nenhum |
| Idioma dominante do código | inglês / português / misto |

Se um item não puder ser inferido com segurança, marque como `[não detectado]` — será perguntado na Fase 2.

---

## Fase 2 — Entrevista estruturada

Após a análise automática, apresente ao usuário **um único bloco** com todas as perguntas abaixo. Não faça uma por uma — entregue tudo de uma vez para que ele responda no ritmo dele.

Informe que itens em branco serão preenchidos com um placeholder genérico e podem ser ajustados depois.

---

**Apresente exatamente assim:**

> Analisei o projeto e preciso de algumas informações que não consigo inferir sozinho.
> Responda o que souber — o que ficar em branco usará um placeholder genérico.
>
> **Sobre o produto:**
> 1. Em uma frase, o que este projeto faz?
> 2. Quem são os usuários? (ex: usuários finais pagantes, time interno, devs)
> 3. Qual a URL de produção, se já existir?
>
> **Regras absolutas (o que eu NUNCA devo fazer):**
> 4. Liste as ações que são terminantemente proibidas neste projeto.
>    (ex: nunca edite migrations existentes, nunca use service_role no frontend, nunca delete sem confirmação)
>    Se não souber agora, escreva "definir depois".
>
> **Áreas que exigem cuidado extra (pare e pergunte antes de agir):**
> 5. Quais mudanças são sensíveis o suficiente para eu parar e pedir confirmação?
>    (ex: qualquer mudança em auth, banco, pagamentos, infraestrutura)
>
> **Comportamento do agente:**
> 6. Que tipo de mudanças posso executar diretamente, sem precisar confirmar?
>    (ex: bugs visuais, novos componentes isolados, ajustes de texto)
> 7. Prefere que eu apresente um plano antes de implementações grandes, ou pode executar direto?
>
> **Preferências de sessão:**
> 8. Em que idioma quer que eu responda? (ex: Português do Brasil, inglês)
> 9. Prefere respostas curtas e diretas, ou explicações detalhadas?
> 10. Tem atalhos de linguagem? (ex: "limpa isso" = remover código morto, "ta bom?" = code review)
>
> **Ambiente de desenvolvimento:**
> 11. Qual SO e shell você usa? (ex: macOS / bash, Windows / Git Bash, Linux / zsh)
> 12. Qual editor? (VS Code, Cursor, outro)
>
> **Deploy e produção:**
> 13. Qual branch aciona o deploy de produção?
> 14. Há algum passo manual necessário após o push? (ex: rodar migrations, deploy de funções)
>
> **Documentação técnica:**
> 15. Quais documentos existem em `docs/` e o que cada um cobre?
>     (Se ainda não existirem, escreva "criar depois")
>
> **Conclusão de sessão:**
> 16. Qual comando deve ser executado ao final de toda sessão com alterações?
>     (ex: /project:done)

---

## Fase 3 — Geração do CLAUDE.md

Com as respostas da entrevista e os dados da análise automática, gere o `CLAUDE.md` completo.

**Regras de geração obrigatórias:**

- Use imperativo direto: "Nunca faça X" — não "É recomendado evitar X"
- Separe invariantes (nunca/sempre) de preferências (prefira/evite)
- Seção de comportamento deve ter gatilhos específicos: "PARE e pergunte quando..." / "EXECUTE sem perguntar quando..."
- Inclua apenas seções com conteúdo real — omita as que não se aplicam
- Não use frases vagas como "tenha cuidado" — escreva o que fazer concretamente
- Para itens não respondidos, use placeholders explícitos: `[definir: descrição do que falta]`
- O documento deve ser completo o suficiente para que um agente novo entenda o projeto sem precisar perguntar o óbvio

**Estrutura obrigatória do CLAUDE.md gerado:**

```
# CLAUDE.md — [Nome do Projeto]

## Produto
[O que é, stack, deploy, URL de produção]

## Leitura Obrigatória — Antes de Qualquer Sessão
[Arquivos que o agente deve ler sempre antes de agir]

## Leitura Sob Demanda
[Tabela: domínio → arquivo de regras]

## Regras Absolutas
[Lista numerada do que nunca pode acontecer]

## Estrutura de Pastas
[Mapa comentado das pastas principais]

## Padrões de Código
[Convenções de TypeScript, componentes, hooks, imports, etc.]

## Escopo de Mudanças
[O que é proibido sem solicitação explícita]

## Comportamento do Agente
### PARE e aguarde resposta antes de executar
[Gatilhos específicos que exigem confirmação]

### EXECUTE sem perguntar
[Ações seguras e reversíveis que podem ser feitas diretamente]

### Conflito entre código e documentação
[Protocolo de resolução]

## Preferências de Sessão
[Idioma, verbosidade, atalhos, ambiente, preferências de código]

## Conclusão de Tarefa
[Comando a executar ao final de toda sessão com alterações]
```

---

## Fase 4 — Aprovação e salvamento

Apresente o rascunho completo no chat e pergunte:

> "Este é o rascunho do CLAUDE.md para este projeto.
> Revise e me diga o que está incorreto, incompleto ou fora do seu estilo de trabalho.
> Posso salvar?"

**Não salve antes da aprovação explícita.**

Após aprovação:

1. Salve em `CLAUDE.md` na raiz do projeto
2. Reporte:

```
✅ CLAUDE.md salvo.

Próximos passos:
- Revise .claude/rules/ — adapte os [ADAPTÁVEL] ao seu stack
- Revise .claude/commands/ — ajuste paths e ferramentas do seu projeto
- Execute /project:start para verificar o estado inicial do ambiente
- Adicione docs/ conforme o projeto crescer
```
