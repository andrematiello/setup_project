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

Informe que:
- Itens em branco usarão um placeholder genérico e podem ser ajustados depois
- Respostas curtas, números das opções ou referências a arquivos (`@docs/arquivo.md`) são aceitas
- Pode pular qualquer item escrevendo "–" ou "depois"

---

**Apresente exatamente assim:**

> Analisei o projeto e preciso de algumas informações que não consigo inferir sozinho.
> Responda o que souber — o que ficar em branco usará placeholder genérico.
> Pode responder com o número da opção, texto livre ou referenciar um arquivo (`@docs/arquivo.md`).
>
> ---
>
> **PRODUTO**
>
> **1. Em uma frase, o que este projeto faz e para quem?**
>    (ou indique um arquivo: `@docs/business.md`, `@README.md`, etc.)
>
> **2. Quem são os usuários neste momento?**
>    a) usuários finais pagantes
>    b) time interno / uso próprio
>    c) beta testers / fase de testes
>    d) outros desenvolvedores / API pública
>    e) outro: ___
>
> **3. URLs do projeto:**
>    - Dev / staging: (ex: dev.meuapp.com, localhost:3000)
>    - Produção: (ex: meuapp.com — ou "ainda não existe")
>
> ---
>
> **REGRAS E LIMITES**
>
> **4. O que eu NUNCA devo fazer neste projeto?**
>    Marque os que se aplicam e adicione os específicos do projeto:
>    [ ] Nunca editar migration existente — sempre criar nova
>    [ ] Nunca usar `service_role` no frontend
>    [ ] Nunca deletar registros, tabelas ou arquivos sem confirmação explícita
>    [ ] Nunca processar pagamento no client-side
>    [ ] Nunca expor secrets em variáveis públicas (`VITE_`, `NEXT_PUBLIC_`)
>    [ ] Nunca contornar RLS ou políticas de acesso como atalho
>    [ ] Nunca alterar auth ou regras de acesso sem aprovação
>    [ ] Outro: ___
>
> **5. Em quais áreas devo PARAR e pedir confirmação antes de agir?**
>    Marque os que se aplicam:
>    [ ] Autenticação / sessão / permissões
>    [ ] Banco de dados (schema, migrations, policies)
>    [ ] Pagamentos / integração financeira
>    [ ] Infraestrutura / variáveis de ambiente / CI-CD
>    [ ] Módulos compartilhados por mais de um domínio
>    [ ] Deploy / edge functions
>    [ ] Outro: ___
>
> **6. O que posso executar DIRETAMENTE, sem confirmar?**
>    Marque os que se aplicam:
>    [ ] Bugs visuais isolados sem efeito em dados
>    [ ] Novos componentes em pasta de domínio correto
>    [ ] Ajustes de texto e layout
>    [ ] Novos hooks de query seguindo padrão existente
>    [ ] Correção de tipo sem alterar lógica
>    [ ] Atualização de documentação
>    [ ] Outro: ___
>
> ---
>
> **COMPORTAMENTO DO AGENTE**
>
> **7. Como prefere que eu trabalhe em implementações grandes?**
>    a) Apresente um plano detalhado, passo a passo, revise comigo antes de executar
>    b) Execute direto e me mostre o resultado
>    c) Depende da complexidade — use Plan Mode para mudanças arquiteturais
>
> **8. Nível de detalhe nas respostas:**
>    a) Curto e direto — só o essencial
>    b) Detalhado para tarefas complexas, curto para as simples
>    c) Sempre detalhado, com contexto e raciocínio
>
> ---
>
> **PREFERÊNCIAS DE SESSÃO**
>
> **9. Idioma das respostas:**
>    a) Português do Brasil
>    b) Inglês
>    c) Outro: ___
>
> **10. Atalhos de linguagem (opcional):**
>    Exemplos comuns — confirme os que quer usar ou adicione os seus:
>    - "limpa isso" → remover código morto e simplificar
>    - "tá bom?" → code review com foco em segurança e padrões
>    - "revisa isso" → análise crítica de implementação
>    - "resumo" → explicação de alto nível sem detalhes de código
>    - "do começo" → reexplique sem assumir contexto anterior
>    Seus atalhos: ___
>
> ---
>
> **AMBIENTE**
>
> **11. Sistema operacional e shell:**
>    a) macOS / zsh
>    b) macOS / bash
>    c) Windows / Git Bash
>    d) Windows / PowerShell
>    e) Linux / zsh
>    f) Linux / bash
>    g) Outro: ___
>
> **12. Editor principal:**
>    a) VS Code
>    b) Cursor
>    c) Windsurf
>    d) Antigravity
>    e) Outro: ___
>
> ---
>
> **DEPLOY**
>
> **13. Qual branch aciona o deploy de produção?**
>    a) main
>    b) master
>    c) production
>    d) Outro: ___
>
> **14. Há passos manuais necessários após o push?**
>    Marque os que se aplicam:
>    [ ] Rodar migrations manualmente
>    [ ] Deploy de Edge Functions
>    [ ] Atualizar variáveis de ambiente em produção
>    [ ] Notificar time / abrir PR para revisão
>    [ ] Nenhum — deploy é totalmente automatizado
>    [ ] Se necessário, pergunte antes de fazer push
>    [ ] Outro: ___
>
> ---
>
> **DOCUMENTAÇÃO**
>
> **15. Documentos em `docs/` (vou verificar automaticamente — confirme ou corrija):**
>    [listar o que detectei na Fase 1, se existir]
>    Adicione o que ficou faltando ou escreva "verificar depois".
>
> ---
>
> **CONCLUSÃO DE SESSÃO**
>
> **16. Qual comando executar ao final de toda sessão com alterações?**
>    a) /project:done (padrão — gera changelog e faz push)
>    b) Outro: ___

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
