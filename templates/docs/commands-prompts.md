# Catálogo de Prompts-Semente — /project:commands

> Use com o **Prompt Mestre** para regenerar qualquer comando adaptado a um novo projeto.
> Fluxo: Prompt Mestre + prompt-semente abaixo → arquivo pronto para o projeto.
> Substitua os itens [ADAPTÁVEL] pelo contexto real do projeto alvo.

---

## /project:setup

```text
Crie um comando /project:setup executado uma única vez após instalar o kit de configuração
Claude Code. Ele deve operar em 4 fases: (1) Análise automática — ler package.json,
lockfiles, configs de deploy, tsconfig, ORM, .env.example e estrutura de pastas para
inferir stack, gerenciador de pacotes, banco, auth, deploy, tipagem e multi-tenancy.
(2) Entrevista estruturada — apresentar um único bloco com 16 perguntas cobrindo:
descrição do produto, usuários, URL de produção; regras absolutas; áreas sensíveis
que exigem confirmação antes de agir; o que pode ser executado diretamente; idioma e
verbosidade das respostas; atalhos de linguagem; SO e editor; qual branch aciona
produção e se há passo manual pós-push; quais docs existem e o que cobrem; e qual
comando encerra sessão. (3) Geração — produzir CLAUDE.md completo com todas as seções:
produto, leitura obrigatória, leitura sob demanda, regras absolutas, estrutura de
pastas, padrões de código, escopo de mudanças, comportamento do agente (PARE /
EXECUTE / conflito código-doc), preferências de sessão e conclusão de tarefa.
Itens não respondidos usam placeholder [definir: descrição]. (4) Aprovação e
salvamento — apresentar rascunho, aguardar aprovação explícita, salvar e reportar
próximos passos.
```

---

## /project:start

```text
Crie um comando /project:start que deve ser executado no início de toda sessão de
trabalho antes de qualquer implementação. Ele deve: (1) ler CLAUDE.md completo e
todos os arquivos listados na seção "Leitura Obrigatória"; (2) verificar em paralelo
o estado do repositório (branch atual, mudanças não commitadas, stash), dependências
com atualizações críticas de segurança, migrations pendentes, status do último deploy
e erros recentes em logs — marcando cada item como aplicável ou não ao projeto;
(3) apresentar um relatório de estado resumido no chat com itens que precisam de
atenção e confirmar "Contexto carregado. Pronto para trabalhar."; (4) gravar log em
logs/start/start-[YYYY-MM-DD_HH-mm].md. Só então aguardar instruções.
```

---

## /project:feature

```text
Crie um comando /project:feature [nome da feature] para implementar novas
funcionalidades com segurança e previsibilidade. Ele deve: ler o contexto e as regras
dos domínios afetados antes de qualquer código; mapear impactos técnicos (arquivos
existentes que serão modificados, arquivos novos, necessidade de migration, impacto em
políticas de acesso e integrações externas) e aguardar confirmação do usuário para
prosseguir; implementar em ordem arquitetural obrigatória (banco → tipos → dados →
lógica de negócio → hooks/stores → componentes de UI → rotas e páginas); aplicar
checklist de qualidade (políticas de acesso para dados novos, loading/error/empty
states, sem any no TypeScript, sem console.log de dados sensíveis, arquivos dentro do
limite de tamanho, inputs validados); atualizar documentação afetada. Finalizar com
relatório contendo o que foi entregue, o que ficou pendente e o que precisa ser
testado manualmente.
```

---

## /project:fix

```text
Crie um comando /project:fix [descrição do bug] para corrigir bugs com método e
rastreabilidade. Ele deve exigir: reprodução do bug com descrição do comportamento
atual vs esperado; identificação da causa raiz antes de qualquer correção (regra
explícita: não corrigir antes de ter a causa clara); correção no ponto correto e em
todas as ocorrências similares no código; verificação de que o bug não reproduz e que
o comportamento adjacente não foi afetado. Incluir etapa de atualização documental
quando o bug revelar lacuna nas regras ou docs, e registro especial em docs/decisions.md
(ou equivalente) para bugs de segurança. Finalizar com relatório no chat contendo:
causa raiz identificada, o que foi corrigido (arquivos e mudanças) e verificações
realizadas. O comando é quase inteiramente genérico — o único item adaptável é o
arquivo de decisões/postmortems do projeto.
```

---

## /project:review

```text
Crie um comando /project:review [arquivo | pasta | "últimas mudanças"] para code
review estruturado por dimensões de prioridade. O escopo deve ser determinado pelo
argumento: arquivo específico, pasta inteira ou git diff HEAD para as últimas mudanças.
As dimensões de análise, em ordem de prioridade, são: (1) Segurança — dados sensíveis
expostos no frontend, políticas de acesso configuradas, inputs validados, secrets em
variáveis públicas, dados de outros tenants acessíveis; (2) Correção — tratamento de
erro em chamadas async, loading/error/empty states, edge cases cobertos; (3) Qualidade
— TypeScript sem any, funções com responsabilidade única, nomes claros, arquivos dentro
do limite de linhas; (4) Performance — queries desnecessariamente amplas, re-renders
desnecessários, assets sem lazy loading; (5) Consistência — segue padrões do projeto,
componentes no lugar correto, usa abstrações existentes. Cada problema encontrado deve
ser reportado com severidade [CRÍTICO / IMPORTANTE / SUGESTÃO], arquivo:linha, descrição
e solução. Finalizar com sumário executivo e veredicto: APROVADO / APROVADO COM
RESSALVAS / PRECISA DE MUDANÇAS.
```

---

## /project:refactor

```text
Crie um comando /project:refactor [arquivo | pasta | componente] para refatoração
estruturada com garantia de comportamento preservado. Ele deve: (1) analisar o código
antes de qualquer mudança — entender o que ele faz, quem depende dele (verificar com
busca antes de alterar), qual o problema atual e em qual camada está; (2) apresentar
um plano ao usuário com o que será mudado e por quê, o que NÃO vai mudar, arquivos
afetados e riscos identificados — aguardando confirmação antes de executar; (3) executar
em passos incrementais e verificáveis, atualizando consumidores impactados e confirmando
comportamento preservado a cada passo; (4) verificar ao final todos os imports/exports
afetados, módulos reutilizados em múltiplos lugares e contratos públicos; (5) atualizar
documentação se a refatoração muda algo documentado, ou registrar que a doc continua
correta se a mudança for só estrutural.
```

---

## /project:document

```text
Crie um comando /project:document [modo] com quatro modos de operação. Modo "completo":
ler estrutura real do código (src/, banco, docs/, configs), mapear entidades/fluxos/
integrações/variáveis de ambiente/rotas e ambiguidades, apresentar mapeamento ao usuário
antes de reescrever, gerar ou atualizar README.md e documentos de arquitetura, modelo
de dados, integrações e decisões — marcando [INFERIDO] para interpretações e [CONFIRMADO]
para fatos observáveis no código. Modo "README": gerar README.md com descrição do
produto, stack, pré-requisitos, instalação, variáveis de ambiente, estrutura de pastas,
fluxos principais e comandos úteis. Modo "feature [nome]": localizar a feature no código
e documentar propósito, entidades envolvidas, fluxo principal, dependências e decisões
não óbvias — com marcação [INFERIDO]/[CONFIRMADO]. Modo "decisões": analisar padrões
arquiteturais reais e adicionar entradas em docs/decisions.md com contexto, decisão,
alternativas descartadas e consequências. Em todos os modos, sempre perguntar ao final:
"O que está incorreto ou faltando?"
```

---

## /project:deploy-check

```text
Crie um comando /project:deploy-check que funciona como gate de qualidade em duas fases
antes e após deploy em produção. Fase 1 — verificação pré-push: (a) secrets — confirmar
que nenhum arquivo .env está rastreado, nenhum secret no staging area e variáveis
públicas não contêm segredos; (b) código — sem console.log com dados sensíveis, sem
código comentado esquecido, testes automatizados passando, sem erros de TypeScript,
build sem erros; (c) banco — migrations pendentes verificadas, políticas de acesso em
tabelas novas, sem migrations destrutivas sem backup confirmado; (d) backend/serviços —
funções deployadas e atualizadas, nenhuma usa credencial privilegiada antes de validar
usuário; (e) integrações — webhooks apontando para produção, serviços externos em modo
live, URLs de callback de auth incluem produção. Para cada item: executar o comando e
reportar ✅ ou 🔴. Um único 🔴 bloqueia o deploy. Se todos ✅, chamar /project:done
automaticamente — que comita, faz push e aciona deploy. Fase 2 — smoke test pós-deploy:
verificar login, fluxo principal, rotas protegidas, operação central e serviços críticos
em produção. Se 🔴: acionar rollback e registrar incidente em runbook.
```

---

## /project:done

```text
Crie um comando /project:done que encerra uma sessão com alterações, garantindo registro
em changelog, validação de documentação, commit, push e eventuais deploys operacionais.
Ele deve: (1) verificar se a sessão teve modificações reais — não se aplica a consultas;
(2) adicionar entrada estruturada em docs/changelog_internal.md com data, resumo, arquivos
modificados, tipo e assinatura do agente; (3) validar e atualizar toda documentação afetada
antes do commit, verificando ponto a ponto sem presumir consistência; (4) fazer commit em
Conventional Commits; (5) avaliar risco da sessão — se envolveu banco, auth, backend,
pagamentos, integrações ou módulo compartilhado, rodar /project:deploy-check antes do
push; senão, push direto; (6) executar deploy de backend/migrations quando aplicável;
(7) gerar relatório final salvo em logs/done/done-[data].md com status de cada etapa.
Acionado pelo usuário explicitamente ou chamado automaticamente pelo /project:deploy-check
ao fim da Fase 1.
```

---

## /project:release

```text
Crie um comando /project:release [versão] para publicar releases formais seguindo
Semantic Versioning (MAJOR.MINOR.PATCH). Ele deve operar em 7 fases: (1) Revisão —
git log desde a última tag, agrupando mudanças por tipo: novidades, correções,
melhorias, segurança e infraestrutura; (2) Gate — executar /project:deploy-check e
bloquear se houver pendências; (3) Bump — atualizar versão em package.json; (4) Tag —
commit de release + tag vX.Y.Z + push da branch e da tag; (5) Changelog formal —
entrada estruturada por tipo em docs/changelog_internal.md; (6) Deploy — comando de
produção do projeto; (7) Relatório — confirmar versão bumped, hash do commit, tag
criada, push, changelog atualizado e status do deploy.
```
