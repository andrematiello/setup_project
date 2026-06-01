# claude-kit

Kit de configuração do ambiente Claude Code para projetos de software.

Instala em qualquer projeto uma estrutura completa de comandos, regras por domínio, skills automáticas e templates de documentação — tudo configurado para que o agente opere com método, segurança e rastreabilidade desde o primeiro uso.

---

## Índice

- [O que é instalado](#o-que-é-instalado)
- [Instalação](#instalação)
- [Atualização](#atualização)
- [Primeiro uso](#primeiro-uso)
- [Início automático de sessão](#início-automático-de-sessão)
- [Comandos](#comandos)
- [Skills automáticas](#skills-automáticas)
- [Rules por domínio](#rules-por-domínio)
- [Documentação instalada](#documentação-instalada)
- [Catálogos de prompts-semente](#catálogos-de-prompts-semente)
- [Estrutura completa instalada](#estrutura-completa-instalada)
- [Personalização](#personalização)
- [Requisitos](#requisitos)
- [Contribuição](#contribuição)

---

## O que é instalado

```text
CLAUDE.md               ← especificação comportamental do agente (gerada em /project:setup)
.claude/
├── commands/           ← protocolo operacional: 11 comandos estruturados
├── rules/              ← regras por domínio: 8 arquivos lidos sob demanda
├── skills/             ← 5 skills automáticas disparadas por contexto
└── settings.json       ← permissões base do agente

docs/
├── changelog_internal.md   ← log de sessões do agente
└── onboarding_morning.md   ← checklist de retomada rápida

templates/docs/
├── commands-prompts.md     ← catálogo de prompts para regenerar comandos
└── docs-prompts.md         ← catálogo de prompts para gerar documentação técnica
```

---

## Instalação

```bash
curl -s https://raw.githubusercontent.com/andrematiello/setup_project/main/setup.sh | bash
```

> **Windows (Git Bash):** se o comando não produzir nenhuma saída, use `--ssl-no-revoke`:
>
> ```bash
> curl -s --ssl-no-revoke https://raw.githubusercontent.com/andrematiello/setup_project/main/setup.sh | bash
> ```

Ou, se preferir inspecionar antes de executar:

```bash
curl -O https://raw.githubusercontent.com/andrematiello/setup_project/main/setup.sh
bash setup.sh
```

Para forçar sobrescrita de arquivos existentes (local):

```bash
bash setup.sh --force
```

Via curl (sem prompt de confirmação):

```bash
curl -s https://raw.githubusercontent.com/andrematiello/setup_project/main/setup.sh | bash -s -- --force
```

---

## Atualização

Para atualizar o kit em um projeto já instalado:

```bash
curl -s --ssl-no-revoke https://raw.githubusercontent.com/andrematiello/setup_project/main/setup.sh | bash -s -- --update
```

O script vai:

1. Baixar cada template do repositório
2. Comparar com o arquivo local
3. **Idêntico ao template** (sem customização) → atualiza automaticamente
4. **Novo arquivo** (não existia no projeto) → instala automaticamente
5. **Divergente** (customização local detectada) → registra em `.claude/update-pending.txt`

Ao final, se houver arquivos divergentes, execute no Claude Code:

```text
/project:update-kit
```

O agente consolida arquivo por arquivo, classificando cada diferença como aditivo, melhoria, customização local, conflito ou remoção — e só avança com sua aprovação.

> `CLAUDE.md` nunca é substituído automaticamente, em nenhum modo.

---

## Primeiro uso

Após a instalação, abra o projeto no Claude Code e execute:

```text
/project:setup
```

O comando opera em 4 fases:

**Fase 1 — Análise automática.** O agente lê os arquivos do projeto (`package.json`, lockfiles, configs de framework, ORM, deploy, `.env.example`, estrutura de pastas) e infere automaticamente: nome do projeto, tipo de produto, framework frontend, banco/ORM, plataforma de deploy, gerenciador de pacotes, TypeScript, multi-tenancy, autenticação e pagamentos.

**Fase 2 — Entrevista estruturada.** Para o que não pôde ser inferido, o agente apresenta um único bloco com 16 perguntas cobrindo: descrição do produto, usuários, URL de produção, regras absolutas, áreas sensíveis, o que pode ser executado sem confirmação, idioma e verbosidade, atalhos de linguagem, SO e editor, branch de produção, passos manuais pós-deploy, documentos existentes e comando de encerramento de sessão. As perguntas são entregues de uma vez — o usuário responde no seu ritmo.

**Fase 3 — Geração do CLAUDE.md.** Com as respostas e os dados inferidos, o agente gera um `CLAUDE.md` completo e adaptado ao projeto, cobrindo: produto e stack, leitura obrigatória por sessão, regras absolutas, estrutura de pastas comentada, padrões de código, escopo de mudanças, comportamento do agente (gatilhos de pausa e execução direta), preferências de sessão e conclusão de tarefa.

**Fase 4 — Aprovação e salvamento.** O rascunho é apresentado no chat para revisão. O agente aguarda aprovação explícita antes de salvar. Após salvar, reporta os próximos passos.

---

## Início automático de sessão

O `CLAUDE.md` gerado pelo kit instrui o agente a executar `/project:start` **automaticamente na primeira mensagem de cada sessão** — sem precisar ser pedido.

O `/project:start` executa 4 verificações em sequência antes de qualquer trabalho:

1. **Onboarding** — lê CLAUDE.md e os arquivos de leitura obrigatória; verifica branch, mudanças pendentes, stash, dependências, migrations e logs de erro.
2. **Security** — checklist diário: variáveis de ambiente públicas, controle de acesso em tabelas, inputs validados, configurações de autenticação e dependências com vulnerabilidades conhecidas.
3. **README** — detecta placeholders não preenchidos (`[definir]`, `TODO`, `???`), seções desatualizadas e links quebrados.
4. **Business** — lê as 3 últimas entradas de `docs/changelog_internal.md` para recuperar contexto da sessão anterior e identificar pendências.

Ao final, apresenta um relatório consolidado no chat e grava log em `logs/start/`.

---

## Comandos

Os comandos ficam em `.claude/commands/` e são invocados com `/project:[nome]`.

| Comando | Quando usar |
| --- | --- |
| `/project:setup` | Uma vez, após instalar o kit |
| `/project:start` | Automático a cada sessão; pode ser invocado manualmente |
| `/project:feature [descrição]` | Implementar nova funcionalidade |
| `/project:fix [descrição]` | Corrigir um bug |
| `/project:review [alvo]` | Code review estruturado |
| `/project:refactor [alvo]` | Refatorar sem alterar comportamento |
| `/project:document [modo]` | Gerar ou atualizar documentação |
| `/project:deploy-check` | Gate de qualidade antes de produção |
| `/project:done` | Encerrar sessão com changelog e push |
| `/project:release [versão]` | Publicar release formal |
| `/project:update-kit` | Consolidar arquivos divergentes após `--update` |

---

### `/project:setup`

**Quando usar:** uma única vez, logo após instalar o kit em um projeto novo.

**O que faz:** analisa automaticamente o codebase, conduz entrevista estruturada em 16 perguntas, gera `CLAUDE.md` personalizado e aguarda aprovação antes de salvar. Sem ele, o agente opera com o template genérico.

---

### `/project:start`

**Quando usar:** automaticamente na primeira mensagem de cada sessão (configurado no CLAUDE.md). Pode ser invocado manualmente.

**O que faz:** rotina de início de sessão com 5 etapas:

1. Lê CLAUDE.md e documentação obrigatória do projeto
2. Verifica estado do repositório (branch, mudanças pendentes, stash) e do ambiente (dependências, migrations, logs)
3. Executa checklist diário de segurança (variáveis, acesso a dados, auth, dependências)
4. Verifica completude do README (placeholders, seções desatualizadas)
5. Recupera contexto de negócio das últimas sessões via `docs/changelog_internal.md`

Apresenta relatório consolidado no chat e grava log em `logs/start/start-[YYYY-MM-DD_HH-mm].md`. Só então aguarda instruções.

---

### `/project:feature [descrição]`

**Quando usar:** ao implementar qualquer nova funcionalidade.

**O que faz:** implementação estruturada em 6 etapas:

1. **Contexto** — lê CLAUDE.md e rules dos domínios afetados
2. **Mapeamento de impacto** — apresenta arquivos a modificar, arquivos a criar, necessidade de migration, impacto em políticas de acesso e integrações — **aguarda confirmação antes de prosseguir**
3. **Implementação em ordem arquitetural** — banco → tipos → dados → lógica de negócio → hooks/stores → UI → rotas
4. **Checklist de qualidade** — políticas de acesso, loading/error/empty states, sem `any`, sem `console.log` sensível, arquivos dentro do limite de linhas, inputs validados
5. **Documentação** — atualiza docs afetados
6. **Relatório** — o que foi entregue, o que ficou pendente, o que precisa de teste manual

---

### `/project:fix [descrição]`

**Quando usar:** ao corrigir qualquer bug — especialmente causa não óbvia, padrão repetido ou área sensível (auth, banco, pagamentos).

**O que faz:** correção estruturada em 6 etapas:

1. **Reprodução** — descreve comportamento atual vs esperado
2. **Causa raiz** — traça o código até a origem; verifica se o padrão existe em outros lugares — **não corrige antes de ter a causa clara**
3. **Correção** — aplica o fix no ponto correto e em todas as ocorrências; comenta quando o motivo não é óbvio
4. **Verificação** — confirma que o bug não reproduz e que o entorno não foi afetado
5. **Documentação** — atualiza rules ou docs se o bug revelou uma lacuna; registra em `docs/decisions.md` se foi erro de segurança
6. **Relatório** — causa raiz, o que foi corrigido, verificações realizadas

---

### `/project:review [arquivo | pasta | "últimas mudanças"]`

**Quando usar:** antes de aprovar código para merge, após feature ou fix relevante.

**O que faz:** code review por 5 dimensões em ordem de prioridade:

1. **Segurança** (prioridade máxima) — dados sensíveis no frontend, políticas de acesso, inputs validados, secrets em variáveis públicas, dados de outros tenants acessíveis
2. **Correção** — tratamento de erro em chamadas async, loading/error/empty states, edge cases
3. **Qualidade** — TypeScript sem `any`, funções com responsabilidade única, nomes claros, arquivos dentro do limite de linhas
4. **Performance** — queries amplas, re-renders, assets sem lazy loading
5. **Consistência** — segue padrões do projeto, componentes no lugar correto, usa abstrações existentes

Cada problema: severidade (`CRÍTICO` / `IMPORTANTE` / `SUGESTÃO`), `arquivo:linha`, descrição, solução. Encerra com veredicto: `APROVADO` / `APROVADO COM RESSALVAS` / `PRECISA DE MUDANÇAS`.

---

### `/project:refactor [arquivo | pasta | componente]`

**Quando usar:** ao reorganizar código sem alterar comportamento externo.

**O que faz:** refatoração estruturada com garantia de comportamento preservado:

1. **Análise** — o que o código faz, quem depende dele (Grep antes de qualquer mudança), qual o problema, em qual camada está
2. **Plano** — o que muda e por quê, o que NÃO muda, arquivos afetados, riscos — **aguarda confirmação**
3. **Execução incremental** — passos pequenos e verificáveis; atualiza consumidores após cada passo
4. **Verificação final** — imports/exports, módulos reutilizados em múltiplos lugares, contratos públicos
5. **Documentação** — atualiza docs se a refatoração muda algo documentado

---

### `/project:document [modo]`

**Quando usar:** ao criar ou atualizar documentação após implementação, refatoração ou decisão arquitetural.

**Modos disponíveis:**

- **`completo`** — lê código real, mapeia entidades/fluxos/integrações/variáveis/rotas, apresenta mapeamento antes de reescrever, gera/atualiza `README.md`, `docs/architecture.md`, `docs/data-model.md`, `docs/integrations.md`, `docs/decisions.md`. Marca `[INFERIDO]` vs `[CONFIRMADO]`.
- **`README`** — gera `README.md` com descrição, stack, pré-requisitos, instalação, variáveis, estrutura de pastas e comandos.
- **`feature [nome]`** — localiza a feature no código e documenta propósito, entidades, fluxo principal, dependências e decisões não óbvias.
- **`decisões`** — analisa padrões arquiteturais reais e adiciona entradas em `docs/decisions.md` com contexto, decisão, alternativas e consequências.

Ao final de qualquer modo, sempre pergunta: "O que está incorreto ou faltando?"

---

### `/project:deploy-check`

**Quando usar:** antes de qualquer push com migration, backend, schema, auth, políticas de acesso ou mudança de risco. Chamado automaticamente pelo `/project:release`.

**O que faz:** gate de qualidade em duas fases. Um único 🔴 bloqueia o deploy.

**Fase 1 — Verificação pré-push:**

- **Secrets e ambiente** — nenhum `.env` rastreado, nenhum secret no staging area, variáveis públicas sem segredos, todas as variáveis de produção configuradas
- **Qualidade de código** — sem `console.log` com dados sensíveis, sem código comentado esquecido, testes passando, sem erros de TypeScript, build sem erros
- **Banco de dados** — migrations pendentes verificadas, políticas de acesso em tabelas novas, sem migrations destrutivas sem backup
- **Backend/serviços** — funções deployadas e atualizadas, nenhuma usa credencial privilegiada antes de validar o usuário
- **Integrações** — webhooks apontando para produção, serviços externos em modo live, URLs de callback de auth configuradas

Se todos ✅, chama `/project:done` automaticamente para commitar, fazer push e acionar o deploy.

**Fase 2 — Smoke test pós-deploy:** login, fluxo principal, rotas protegidas, operação central e serviços críticos. Se 🔴: rollback e registro em `docs/runbook.md`.

---

### `/project:done`

**Quando usar:** ao final de toda sessão com alterações. Não se aplica a sessões apenas de consulta. Pode ser chamado automaticamente pelo `/project:deploy-check`.

**O que faz:** encerramento de sessão em 6 etapas:

1. **Changelog** — entrada estruturada em `docs/changelog_internal.md` com data, resumo, arquivos modificados, tipo de alteração e assinatura do agente
2. **Documentação** — valida e atualiza todos os docs afetados antes do commit; não faz commit com documentação desatualizada
3. **Commit** — Conventional Commits com `Co-Authored-By` do agente
4. **Push** — avalia risco da sessão; se envolveu banco, auth, pagamentos, backend ou módulo compartilhado, executa `/project:deploy-check` antes; senão, push direto
5. **Deploy de backend/migrations** — quando aplicável ao projeto
6. **Relatório final** — salvo em `logs/done/done-[YYYY-MM-DD_HH-mm].md`

---

### `/project:release [versão]`

**Quando usar:** ao publicar versão formal. Segue [Semantic Versioning](https://semver.org/) (`MAJOR.MINOR.PATCH`).

| Tipo de mudança | Versão |
| --- | --- |
| Correção de bug sem impacto em contratos | PATCH |
| Nova feature sem breaking change | MINOR |
| Breaking change em API, schema ou contrato | MAJOR |

**O que faz:** publicação em 7 fases:

1. **Revisão** — `git log` desde a última tag; agrupa mudanças por tipo
2. **Gate** — executa `/project:deploy-check`; bloqueia se houver pendências
3. **Bump** — atualiza versão em `package.json`
4. **Tag** — commit de release + tag `vX.Y.Z` + push da branch e da tag
5. **Changelog formal** — entrada por tipo em `docs/changelog_internal.md`
6. **Deploy de produção** — comando de deploy do projeto
7. **Relatório** — hash do commit, tag criada, push, changelog e status do deploy

---

### `/project:update-kit`

**Quando usar:** após rodar `setup.sh --update` e existir `.claude/update-pending.txt` com arquivos divergentes.

**O que faz:** consolida arquivo por arquivo, bloco por bloco, classificando cada diferença:

| Categoria | Critério |
| --- | --- |
| `ADITIVO` | Seção nova no template que o local não tem → adota automaticamente |
| `PLACEHOLDER` | Local preencheu um `[definir]` com conteúdo real → preserva sempre |
| `PROJETO-ESPECÍFICO` | Local tem stack, URLs, nomes ou regras do projeto → preserva sempre |
| `MELHORIA` | Template atualizou seção não tocada localmente → adota, registra o que mudou |
| `SEGURANÇA` | Mudança em regra de segurança → adota a versão mais restritiva |
| `CONFLITO` | Template e local divergem na mesma seção → apresenta as duas versões e pergunta |
| `REMOÇÃO` | Template removeu algo que ainda existe no local → pergunta antes de remover |

Para cada `CONFLITO` ou `REMOÇÃO`, apresenta as versões com análise e oferece opções (manter, adotar, consolidar ou pular). Após processar todos os blocos de um arquivo, apresenta o resultado consolidado e aguarda aprovação antes de salvar. Remove `.claude/update-pending.txt` ao concluir tudo.

---

## Skills automáticas

Skills ficam em `.claude/skills/[nome]/SKILL.md` e são **disparadas automaticamente** quando o contexto da conversa corresponde às suas condições de ativação — sem necessidade de o usuário invocar nada.

---

### `code-review`

**Disparada quando:** o pedido contém termos como revisar, melhorar, refatorar, está bom, o que acha, tem problema ou pode melhorar.

**O que faz:** analisa o escopo, lê os arquivos relevantes, revisa pelas 5 dimensões (segurança → correção → qualidade → performance → consistência), registra achados com severidade e localização, e encerra com sumário executivo e recomendação.

**Nunca faz:** começar pela conclusão antes dos achados; tratar problema de segurança como sugestão cosmética.

---

### `security-check`

**Disparada quando:** a implementação toca autenticação, banco de dados, pagamentos, variáveis de ambiente, dados de usuário, APIs externas ou webhooks.

**O que faz:** verifica checklist de segurança **antes** de escrever qualquer código. Valida proteção de rota e sessão (auth), isolamento por tenant e políticas de acesso (banco), autenticação, autorização e validação de input (APIs), separação público/privado (variáveis) e assinatura de webhook antes de processar. Sinaliza riscos e bloqueios ao usuário antes de implementar.

**Nunca faz:** deixar a revisão de segurança para depois do código; prosseguir com risco crítico sem avisar; assumir que frontend resolve proteção real.

---

### `update-docs`

**Disparada quando:** uma implementação foi concluída e o agente está prestes a apresentar o resultado final.

**O que faz:** identifica arquivos criados/alterados/removidos, mapeia o tipo de mudança para os docs corretos (nova tabela → schema; nova rota → arquitetura; nova regra de negócio → domínio; nova feature → features.md), atualiza os docs antes de apresentar o resultado e informa ao usuário quais foram atualizados.

**Nunca faz:** apresentar implementação concluída sem revisar docs; documentar intenção futura como fato; manter doc desatualizado quando o comportamento real mudou.

---

### `new-migration`

**Disparada quando:** o pedido envolve alterar schema do banco: adicionar ou remover coluna, criar tabela, alterar tipo de campo, adicionar índice, modificar política de acesso ou qualquer mudança de schema versionado.

**O que faz:** lê `.claude/rules/database.md`, verifica se a mudança é destrutiva (para e pede confirmação se for), cria nova migration seguindo o padrão do projeto, ajusta políticas de acesso afetadas, aplica a migration e atualiza tipos gerados automaticamente.

**Nunca faz:** editar migration existente; criar tabela sem políticas de acesso; alterar schema sem revisar impacto em isolamento multi-tenant.

---

### `security-audit`

**Disparada quando:** o usuário pede auditoria de segurança, revisão de segurança, threat modeling, análise de vulnerabilidades, avaliação de maturidade, checklist de segurança, pentest assessment, análise de risco, hardening ou conformidade OWASP/NIST — ou menciona: isolamento multi-tenant, gestão de segredos, segurança de CI/CD, resposta a incidentes ou prompt injection.

**Diferença em relação ao `security-check`:**

| | `security-check` | `security-audit` |
| --- | --- | --- |
| **Quando** | Durante implementação, ao tocar áreas sensíveis | Sob demanda explícita |
| **Escopo** | Pontual — auth, banco, APIs, env vars | Amplo — arquitetura inteira, 30 domínios |
| **Output** | Sinais e bloqueios antes de escrever código | Relatório com achados por severidade, OWASP, NIST |
| **Analogia** | Guarda de segurança na porta | Auditor fazendo uma perícia completa |

**O que faz:** auditoria técnica seguindo OWASP ASVS, OWASP Top 10, NIST SSDF e CISA Secure by Design, cobrindo 30 domínios:

| # | Domínio | # | Domínio |
| --- | --- | --- | --- |
| 1 | Arquitetura de segurança | 16 | CI/CD seguro |
| 2 | Threat modeling (STRIDE) | 17 | Ambientes e separação de responsabilidades |
| 3 | Autenticação | 18 | Logging, auditoria e trilha forense |
| 4 | Autorização e controle de acesso | 19 | Monitoramento e detecção de anomalias |
| 5 | Isolamento multi-tenant | 20 | Backup, recuperação e continuidade |
| 6 | Banco de dados e proteção de dados | 21 | Resposta a incidentes |
| 7 | Criptografia em trânsito e em repouso | 22 | Secure by design e secure by default |
| 8 | Gestão de segredos | 23 | Conformidade OWASP ASVS, Top 10, NIST SSDF |
| 9 | Segurança de APIs | 24 | Testes de segurança (SAST, DAST, pentest) |
| 10 | Validação de entrada e prevenção de injeção | 25 | Administração e contas privilegiadas |
| 11 | Upload de arquivos | 26 | Privacidade e minimização de dados |
| 12 | Sessão, cookies e tokens | 27 | Integrações externas |
| 13 | Frontend seguro | 28 | Hardening de infraestrutura |
| 14 | Backend como autoridade única | 29 | Segurança de IA e prompts |
| 15 | Dependências e supply chain | 30 | Critérios objetivos de aceite de segurança |

Para cada domínio: o que está sendo avaliado, resultado esperado, tabela de achados com severidade (`Crítico` / `Alto` / `Médio` / `Baixo`), impacto, recomendação e critério de aceite auditável (aprovado/reprovado com evidência esperada).

Ao final, gera relatório executivo em `logs/security/security-[data].md` com: total por severidade, top 15 riscos, nível de maturidade de segurança (Inicial → Otimizado) e roadmap de remediação em 3 fases.

**Nunca faz:** fornecer código de exploração funcional; usar terminologia imprecisa ("criptografia forte" em vez de "AES-256-GCM"); misturar fato técnico com opinião.

---

## Rules por domínio

Rules ficam em `.claude/rules/` e são lidas sob demanda — o agente as consulta ao trabalhar no domínio correspondente. Cada rule define o que nunca pode acontecer, o que requer confirmação e os padrões obrigatórios com exemplos de código.

---

### `security.md`

**Lida quando:** a implementação toca auth, banco, pagamentos, webhooks, backend ou dados de usuário.

**Cobre:**

- Proibições absolutas: chaves de serviço no frontend, secrets em variáveis públicas, confiar em dados vindos do cliente, contornar políticas de acesso, processar pagamento no client-side, retornar stack traces ou dados de outros tenants, SQL com concatenação de string de usuário, processar webhook sem validar assinatura
- O que requer confirmação: remoção de tabelas/colunas/políticas, tornar endpoint público, migrations destrutivas, alterações em auth ou RBAC, mudança de variáveis de ambiente de produção
- Classificação de variáveis de ambiente (públicas vs privadas) com exemplos
- Padrão de políticas de acesso multi-tenant com SQL de referência
- Validação de input com Zod — correto vs incorreto com exemplos de código
- Padrão de webhooks: validação de assinatura, idempotência, tratamento de reenvio
- Checklist pré-produção completo: auth, banco, inputs, secrets e integrações

---

### `auth.md`

**Lida quando:** a implementação toca login, signup, sessão, logout, proteção de rota, roles ou provedor de auth.

**Cobre:**

- Padrão de rota autenticada com exemplos para React e Next.js App Router
- Padrão de rota admin com checagem de role
- Separação: role no frontend serve apenas para UX; proteção real ocorre no backend e banco
- Sessão em contexto central com `session`, `user`, `loading` e `signOut` — sem duplicação
- Logout correto: sempre via `signOut` do provedor, invalidando sessão no servidor
- Configurações obrigatórias do provedor para produção: confirmação de e-mail, URLs de redirect, política de recuperação de senha

---

### `database.md`

**Lida quando:** a implementação envolve schema, migrations, queries, políticas de acesso ou ORM.

**Cobre:**

- Regra principal: nunca edite migration existente; toda mudança de schema exige nova migration
- Padrão de query com tratamento de erro — correto vs incorreto com exemplos
- Regras de migration: habilitação de acesso em tabelas novas, confirmação para destrutivas, atualização de tipos gerados
- Template SQL de tabela com políticas de acesso para isolamento multi-tenant
- Quando usar backend privilegiado em vez de query direta
- Convenções de nomenclatura: tabelas, colunas, foreign keys, índices — tudo `snake_case`

---

### `typescript.md`

**Lida quando:** qualquer arquivo TypeScript é criado ou alterado.

**Cobre:**

- Proibições absolutas: `any`, `@ts-ignore`, `@ts-expect-error` como atalho, `as` sem necessidade, `!` para contornar nulidade
- Tipos utilitários preferidos: `Partial<T>`, `Pick<T, K>`, `Omit<T, K>`, `Record<K, V>` com exemplos
- Tipagem explícita de props com interface acima do componente
- Retorno de hooks com objeto nomeado e tipo explícito em hooks com API pública
- `export type` vs `export interface`, `import type` para imports puramente tipados
- Funções assíncronas com retorno `Promise<T>` explícito
- Event handlers tipados com tipos do React e convenção de nomenclatura `handle`

---

### `testing.md`

**Lida quando:** testes são criados, modificados ou avaliados.

**Cobre:**

- Stack padrão: Vitest + `@testing-library/react`
- O que testar obrigatoriamente: funções puras em `src/lib/`, hooks críticos, transições de estado não triviais, casos de borda
- O que não testar: componentes simples de renderização, chamadas ao banco, funções serverless, comportamento garantido pelo TypeScript
- Estrutura de arquivo de teste: localização, nomenclatura e imports
- Convenção de `describe` e `it` com exemplos orientados a comportamento
- 4 casos obrigatórios por teste: happy path, entrada inválida/vazia, casos de borda, comportamento negativo
- Padrões de mocks: `vi.useFakeTimers()`, `vi.fn()`, limpeza de localStorage; proibição de mockar o banco
- `renderHook` com `act` para hooks com estado
- Cobertura mínima: 100% das funções exportadas em `src/lib/`, hooks críticos com happy path e casos de erro

---

### `components.md`

**Lida quando:** componentes React são criados, modificados ou refatorados.

**Cobre:**

- Regra absoluta: nunca modifique componentes gerenciados por biblioteca de UI (shadcn/ui, Radix); customizações via `className` e variantes
- Estrutura de pastas: `ui/` (biblioteca — nunca editar), `shared/` (2+ domínios), `[domínio]/` (exclusivo de um domínio), `layout/` (shell e navegação)
- Convenções: named exports (nunca `default`), componentes funcionais, máximo 300 linhas, sem lógica de negócio no componente
- Padrão de `cn()` para classes condicionais vs template literals (correto vs incorreto)
- Padrão de componente puro vs componente conectado a dados
- Formulários: React Hook Form + Zod com exemplo completo
- Imports sempre absolutos com `@/`

---

### `code-style.md`

**Lida quando:** código é criado, movido ou revisado.

**Cobre:**

- Nomenclatura por tipo: componentes (`PascalCase.tsx`), hooks (`useCamelCase.ts`), utilitários (`kebab-case.ts`), variáveis e funções (`camelCase` em inglês), tipos (`PascalCase`)
- Ordem interna obrigatória de componente: imports → tipos → export → estado → contextos → hooks de dados → valores derivados → handlers → JSX
- Padrões de hooks: `src/hooks/`, queryKey com `orgId`/`tenantId`, `enabled: !!orgId`, `useMutation` invalida queries em `onSettled`
- TypeScript: sem `any`, sem `@ts-ignore`, narrowing e unions, `import type`
- Commits: Conventional Commits com `Co-Authored-By` do agente; tipos: `feat`, `fix`, `refactor`, `docs`, `style`, `test`, `chore`
- Proibições com exemplos: import relativo profundo, lógica de negócio em componente, `default export` em componentes novos

---

### `documentation.md`

**Lida quando:** qualquer mudança que afete comportamento, estrutura ou regras do projeto é implementada.

**Cobre:**

- **CHANGELOG.md:** quando atualizar (nova funcionalidade, bug, mudança de comportamento, adição/remoção de template, alteração no `setup.sh` ou README); formato obrigatório Adicionado/Alterado/Corrigido/Removido; entradas mais recentes no topo
- **docs/business-domain.md:** quando atualizar (regras de negócio, invariantes, fluxos de estado, glossário, decisões de produto); quando não atualizar (mudanças puramente técnicas)
- **README.md:** quando atualizar (novo comando, mudança na instalação, mudança na estrutura); quando não atualizar (mudanças internas sem impacto na experiência)
- Ordem ao encerrar sessão: CHANGELOG → business-domain → README → commit e push

---

## Documentação instalada

### `docs/changelog_internal.md`

Log cronológico das mudanças realizadas pelo agente em cada sessão. Preenchido automaticamente pelo `/project:done`.

Cada entrada contém: data e hora, título em Conventional Commits, resumo descritivo com contexto suficiente para entender sem consultar o código, lista de arquivos modificados com tipo de mudança, hash do commit e assinatura do agente. Entradas mais recentes no topo. Nunca deletar entradas antigas.

---

### `docs/onboarding_morning.md`

Checklist de retomada rápida para início de sessão. Cobre: leitura obrigatória (CLAUDE.md e docs críticos), estado do repositório (git status, log, conflitos, stash), estado do ambiente (dependências, variáveis, banco local), prioridade da sessão (tarefa, pendências anteriores, necessidade de Plan Mode) e sinais de alerta que exigem confirmação antes de prosseguir.

---

## Catálogos de prompts-semente

Ficam em `templates/docs/` — ferramentas para adaptar o kit a novos projetos ou regenerar arquivos com comportamento diferente.

---

### `templates/docs/commands-prompts.md`

Um prompt-semente para cada um dos 11 comandos. Cada prompt descreve exatamente o que o comando deve fazer, pronto para ser usado com um "Prompt Mestre" que gera a versão adaptada para o projeto-alvo.

**Casos de uso:** regenerar um comando com comportamento diferente do padrão; criar variantes para projetos com stack específica; compartilhar com outros times.

---

### `templates/docs/docs-prompts.md`

Um prompt-semente para cada documento técnico que o kit pode gerar. Cobre 15 tipos de documento:

| Documento | Propósito |
| --- | --- |
| `agents.md` | Guardrails operacionais e limites arquiteturais para agentes de IA |
| `architecture.md` | Mapa estrutural do sistema — onde cada tipo de código deve viver |
| `data-flow.md` | Como os dados se movem: leitura, escrita, auth, real-time |
| `data-model.md` | Schema com significado e regras de negócio por entidade |
| `business-domain.md` | Glossário, invariantes, regras de negócio, fluxos de estado |
| `features.md` | Catálogo de funcionalidades com fluxo principal e regras |
| `decisions.md` | ADRs — contexto, decisão, alternativas descartadas, consequências |
| `security-policy.md` | Modelo de ameaças, defesa em profundidade, política de secrets |
| `infrastructure.md` | Frontend, backend, banco, serviços externos, variáveis, scripts |
| `integrations.md` | Cada serviço externo: propósito, localização no código, troubleshooting |
| `contributing.md` | Convenções específicas do projeto: nomenclatura, estrutura, padrões |
| `developer-onboarding.md` | Setup local do zero para desenvolvedor novo |
| `runbook.md` | Resposta a incidentes por cenário crítico: diagnóstico e ações |
| `onboarding_morning.md` | Checklist de início de sessão para o agente |
| `changelog_internal.md` | Log de sessões com estrutura de entrada detalhada |

---

## Estrutura completa instalada

```text
.claude/
├── commands/
│   ├── setup.md            ← /project:setup
│   ├── start.md            ← /project:start (automático a cada sessão)
│   ├── feature.md          ← /project:feature [descrição]
│   ├── fix.md              ← /project:fix [descrição]
│   ├── review.md           ← /project:review [arquivo | pasta | "últimas mudanças"]
│   ├── refactor.md         ← /project:refactor [arquivo | pasta | componente]
│   ├── document.md         ← /project:document [completo | README | feature | decisões]
│   ├── deploy-check.md     ← /project:deploy-check
│   ├── done.md             ← /project:done
│   ├── release.md          ← /project:release [versão]
│   └── update-kit.md       ← /project:update-kit
├── rules/
│   ├── security.md         ← lida ao tocar auth, banco, pagamentos, webhooks, backend
│   ├── auth.md             ← lida ao tocar login, sessão, roles, proteção de rota
│   ├── database.md         ← lida ao tocar schema, migrations, queries, ORM
│   ├── typescript.md       ← lida ao criar ou alterar arquivos TypeScript
│   ├── testing.md          ← lida ao criar, modificar ou avaliar testes
│   ├── components.md       ← lida ao criar ou refatorar componentes React
│   ├── code-style.md       ← lida ao criar, mover ou revisar código
│   └── documentation.md    ← lida ao implementar qualquer mudança com impacto externo
├── skills/
│   ├── code-review/
│   │   └── SKILL.md        ← automática: revisar, melhorar, está bom, o que acha
│   ├── security-check/
│   │   └── SKILL.md        ← automática: auth, banco, pagamentos, variáveis, APIs
│   ├── security-audit/
│   │   └── SKILL.md        ← automática: auditoria, threat modeling, OWASP, NIST
│   ├── update-docs/
│   │   └── SKILL.md        ← automática: ao concluir qualquer implementação
│   └── new-migration/
│       └── SKILL.md        ← automática: alterações de schema do banco
└── settings.json           ← permissões base: git, package manager, filesystem

docs/
├── changelog_internal.md   ← log de sessões (preenchido pelo /project:done)
└── onboarding_morning.md   ← checklist de retomada de sessão

templates/docs/
├── commands-prompts.md     ← prompts-semente para regenerar os 11 comandos
└── docs-prompts.md         ← prompts-semente para gerar 15 tipos de documentação

CLAUDE.md                   ← gerado pelo /project:setup, personalizado para o projeto
```

---

## Personalização

Todos os arquivos instalados são pontos de partida. Dois marcadores indicam o nível de adaptação necessário:

- **`[ADAPTÁVEL]`** — deve ser ajustado ao projeto: substitua os placeholders com a stack real, paths, ferramentas e fluxos do projeto.
- **`[GENÉRICO]`** — funciona sem modificação na maioria dos projetos web modernos.

**Por onde começar após o `/project:setup`:**

1. Revise `.claude/rules/` — adapte os itens `[ADAPTÁVEL]` à sua stack (banco, auth, componentes)
2. Revise `.claude/commands/` — ajuste paths e comandos de build/test/deploy ao seu projeto
3. Execute `/project:start` para verificar o estado inicial do ambiente
4. Crie documentos em `docs/` conforme o projeto crescer — use os prompts-semente de `templates/docs/docs-prompts.md`

Para regenerar qualquer comando com comportamento diferente, use o prompt-semente correspondente em `templates/docs/commands-prompts.md`.

---

## Requisitos

- [Claude Code](https://claude.ai/code) instalado
- `curl` disponível no terminal
- Git inicializado no projeto

---

## Contribuição

Abra uma issue ou pull request em [andrematiello/setup_project](https://github.com/andrematiello/setup_project).
