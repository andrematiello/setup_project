# Catálogo de Prompts-Semente — docs/

> Use com o **Prompt Mestre** para gerar cada documento de documentação técnica
> adaptado a um novo projeto. Fluxo: Prompt Mestre + prompt-semente → rascunho pronto.
>
> Leia o codebase antes de gerar — todo documento deve refletir o que existe no código,
> não o que deveria existir. Marque [INFERIDO] para interpretações e [CONFIRMADO] para
> fatos observáveis diretamente no código.

---

## agents.md — Guardrails do agente

```text
Crie um arquivo agents.md que define os guardrails operacionais e limites arquiteturais
para agentes de IA trabalhando neste repositório. Ele deve cobrir: (1) princípios
centrais — o que o agente sempre deve fazer (preservar consistência arquitetural,
preferir mudanças mínimas e reversíveis, seguir padrões existentes) e o que nunca deve
fazer (inventar arquitetura sem evidência, introduzir dependências sem justificativa,
mover lógica sensível para o frontend, expor secrets, fazer mudanças destrutivas
silenciosamente); (2) guardrails arquiteturais — áreas que não podem ser alteradas
sem discussão explícita (auth, autorização, modelo de dados, schema, rotas, contratos
de API, estratégia de deploy); (3) guardrails de segurança — validação server-side,
isolamento de dados por tenant/usuário, inputs validados, permissões respeitadas;
(4) protocolo de mudanças não-triviais — sequência obrigatória de entendimento,
mapeamento de impacto, proposta e aprovação antes de executar; (5) proibição de
invenção — não criar endpoints, tabelas ou fluxos sem evidência no código; (6)
protocolo de recuperação de erros — parar, reverter, reportar, propor alternativa;
(7) protocolo de conclusão de tarefa — sempre executar /project:done ao final.
```

---

## architecture.md — Mapa estrutural do sistema

```text
Crie um arquivo architecture.md que serve como mapa estrutural do sistema e critério
de decisão para onde novo código deve viver. Ele deve conter: (1) critério de decisão
— uma tabela ou regra que responde "em qual camada este código pertence?" para cada
tipo de responsabilidade do projeto; (2) diagrama de camadas — representação visual
(Mermaid ou texto) mostrando dependências entre camadas e o que cada uma pode ou não
importar; (3) tabela de camadas — para cada camada: responsabilidade única, o que
nunca faz, exemplo correto e exemplo incorreto; (4) matriz de dependências — o que
cada camada pode e não pode importar das demais; (5) inventário de hooks e componentes
críticos com descrição resumida — atualizado conforme o projeto cresce. Gere baseado
no que existe no código, não no que seria ideal.
```

---

## data-flow.md — Como os dados se movem

```text
Crie um arquivo data-flow.md que descreve como os dados se movem pelo sistema. Ele
deve cobrir: (1) princípio central de validação — onde cada tipo de validação deve
ocorrer (UX no frontend, segurança e integridade no backend/banco); (2) padrão de
fluxo de leitura — da UI até o banco, com camadas intermediárias; (3) padrão de
fluxo de escrita — da ação do usuário até a persistência, incluindo invalidação de
cache; (4) fluxo de autenticação — do login à sessão estabelecida e ao primeiro dado
carregado; (5) fluxos detalhados das operações centrais do produto — descreva as 3-5
operações mais importantes do sistema passo a passo; (6) validações por camada —
tabela mostrando o que cada camada valida; (7) tratamento de erros — padrão de
resposta de erro por camada; (8) real-time/websockets se aplicável. Baseie-se no
código existente — marque [INFERIDO] onde não for 100% confirmável.
```

---

## data-model.md — Schema e significado dos dados

```text
Crie um arquivo data-model.md que documenta o modelo de dados do projeto. Ele deve
conter: (1) convenções de nomenclatura — padrões de nomes para tabelas, colunas, foreign
keys, timestamps e campos de texto livre; (2) diagrama de relacionamentos (Mermaid ERD
ou equivalente) mostrando as entidades principais e como se relacionam; (3) para cada
entidade relevante: propósito, campos com tipo e descrição, invariantes observáveis
no schema (constraints, NOT NULL, defaults) e invariantes de negócio que precisam de
confirmação humana. Distinção importante: o schema SQL diz o que existe; este arquivo
registra significado e regras de negócio que não são óbvias pela estrutura. Marque
[INFERIDO] para interpretações e [CONFIRMADO] para fatos diretamente observáveis nas
migrations.
```

---

## business-domain.md — Regras de negócio e invariantes

```text
Crie um arquivo business-domain.md que documenta as regras de negócio e invariantes
do domínio que qualquer desenvolvedor ou agente precisa conhecer antes de implementar.
Ele deve cobrir: (1) glossário do domínio — termos centrais do produto com definição
precisa, evitando ambiguidade; (2) invariantes do sistema — regras que sempre devem
ser verdadeiras, independentemente de qual código as implemente (ex: um usuário só vê
dados do seu workspace, um evento não pode ter data de fim anterior ao início);
(3) regras de negócio por módulo — para cada módulo central do produto, as regras
que governam seu comportamento; (4) fluxos de estado — para entidades com ciclo de
vida (ex: tarefas, assinaturas), os estados possíveis e transições válidas;
(5) restrições não óbvias — decisões de produto que parecem arbitrárias mas têm
justificativa. Marque [INFERIDO] onde a regra foi deduzida do comportamento do código,
não de especificação explícita.
```

---

## features.md — Catálogo de funcionalidades

```text
Crie um arquivo features.md que serve como catálogo completo de todas as
funcionalidades do produto. Para cada módulo ou feature: (1) propósito em uma frase;
(2) rotas ou pontos de entrada (URL, comando, evento); (3) entidades de dados
envolvidas; (4) fluxo principal — o que acontece quando o usuário executa a ação
central da feature; (5) regras de negócio específicas — comportamentos que não são
óbvios pelo nome da feature; (6) estado atual de implementação — implementado,
parcial ou planejado. Inclua também: mapa de rotas completo (públicas e autenticadas)
e seção de regras de negócio centrais que se aplicam a múltiplas features. Baseie-se
no código, não na especificação desejada.
```

---

## decisions.md — Registro de decisões arquiteturais (ADRs)

```text
Crie um arquivo decisions.md que registra as decisões arquiteturais relevantes do
projeto no formato ADR (Architecture Decision Record). O objetivo não é documentar o
óbvio, mas preservar o *porquê* de decisões que, sem contexto, parecem questionáveis.
Para cada decisão: (1) título e número sequencial; (2) data e status (Ativo / Superado
/ Em revisão); (3) contexto — qual problema ou necessidade motivou a decisão;
(4) decisão — o que foi escolhido; (5) alternativas descartadas — com breve justificativa
para cada uma; (6) consequências — pontos positivos (✅) e trade-offs ou riscos (⚠️).
Priorize registrar: escolha de banco/ORM, estratégia de autenticação, modelo de
multi-tenancy se aplicável, escolha de deploy, qualquer decisão que gerou debate ou
que foi não-óbvia.
```

---

## security-policy.md — Política de segurança

```text
Crie um arquivo security-policy.md que documenta o raciocínio por trás das restrições
de segurança do projeto. Ele deve cobrir: (1) modelo de ameaças — os 3-5 riscos mais
críticos para este produto específico, com descrição do risco, mitigação principal e
onde ela é implementada; (2) defesa em profundidade — mapa de onde cada tipo de
validação ocorre (frontend / backend / banco) e por que cada camada é necessária;
(3) política de secrets e variáveis de ambiente — o que é público vs privado, onde
cada tipo de chave é usado e o que nunca pode aparecer no frontend; (4) modelo de
autorização — como permissões são verificadas e em qual camada a proteção real ocorre;
(5) checklist pré-produção — o que verificar antes de qualquer deploy envolvendo auth,
banco, inputs, secrets ou integrações externas.
```

---

## infrastructure.md — Infraestrutura e deploy

```text
Crie um arquivo infrastructure.md que descreve a infraestrutura real do projeto — o
que existe no código e está configurado, não o que seria ideal. Ele deve cobrir:
(1) visão geral — diagrama textual ou Mermaid mostrando os componentes principais e
como se conectam; (2) frontend e deploy — plataforma, tipo de app (SPA/SSR/SSG),
arquivo de config, onde os assets são publicados, fallback para SPA se aplicável;
(3) backend e banco — componentes em uso, o que está implementado vs planejado;
(4) serviços externos — quais APIs e plataformas externas o sistema usa;
(5) variáveis de ambiente — tabela completa com variável, propósito e se é pública
ou privada; (6) scripts e comandos — o que cada script de deploy faz e quando usar;
(7) gaps operacionais — o que ainda não está implementado ou documentado e que pode
causar surpresa em produção.
```

---

## integrations.md — Serviços externos e integrações

```text
Crie um arquivo integrations.md que documenta cada serviço externo que o projeto
consome. Para cada integração: (1) propósito — o que o projeto usa deste serviço;
(2) componentes em uso — funcionalidades específicas do serviço que estão integradas;
(3) onde vive no código — camada (frontend, backend, Edge Function) e arquivos
principais; (4) variáveis de ambiente necessárias; (5) estado atual — implementado,
parcial ou planejado; (6) troubleshooting — sintomas comuns de falha e como diagnosticar.
Inclua também um mapa visual inicial mostrando todos os serviços e como se conectam
ao sistema.
```

---

## contributing.md — Convenções do projeto

```text
Crie um arquivo contributing.md que documenta as convenções específicas deste projeto
— não um guia genérico de boas práticas, mas as regras que este codebase em particular
adota. Deve cobrir: (1) nomenclatura — tabela com tipo de artefato (componente, hook,
utilitário, página, migration, etc.) e convenção de nome com exemplo; (2) estrutura
interna de componente — ordem obrigatória das seções com exemplo de código;
(3) padrões de hooks — onde ficam, como estruturar queryKey, quando usar enabled,
como invalidar em onSettled; (4) padrões de estilo — biblioteca de UI, como lidar com
classes condicionais, tokens de tema vs valores hardcoded; (5) padrões de formulário
se aplicável; (6) imports — sempre absolutos, convenção de alias.
```

---

## developer-onboarding.md — Guia de setup local

```text
Crie um arquivo developer-onboarding.md que guia um desenvolvedor novo a rodar o
projeto localmente do zero. Deve conter: (1) pré-requisitos — ferramentas necessárias
com versão mínima e propósito de cada uma; (2) setup local passo a passo — clone,
install, configurar variáveis de ambiente (com referência a .env.example), rodar em
desenvolvimento e acessar; (3) build de produção local; (4) estrutura do repositório
— mapa comentado das pastas principais; (5) convenções e padrões — link para
contributing.md e resumo dos pontos críticos; (6) como adicionar uma feature — fluxo
resumido da decisão de arquitetura até o PR; (7) como criar ou modificar backend —
se o projeto tiver funções serverless, migrations ou schema gerenciado, explicar o
fluxo de criação, teste e deploy.
```

---

## runbook.md — Resposta a incidentes

```text
Crie um arquivo runbook.md que documenta procedimentos de resposta a incidentes em
produção. Para cada cenário crítico do projeto: (1) nome do incidente e sintomas
observáveis — o que o usuário/monitor reporta; (2) diagnóstico rápido — checklist
de 3-5 verificações para identificar a causa, com comandos concretos quando aplicável;
(3) resposta — ações imediatas em ordem de prioridade; (4) validação — como confirmar
que o problema foi resolvido. Cenários mínimos a cobrir: banco inacessível ou com
schema inconsistente, falha de deploy (rollback), serviço externo falhando (webhook,
pagamento, auth), Edge Function com erro repetido, vazamento acidental de secret.
Escreva para situações de pressão — cada seção deve ser legível em segundos, não
parágrafos.
```

---

## onboarding_morning.md — Checklist de início de sessão

```text
Crie um arquivo onboarding_morning.md como checklist de retomada rápida no início
de cada sessão de trabalho. Deve cobrir: (1) leitura obrigatória — arquivos que o
agente lê antes de agir (CLAUDE.md e docs críticos do projeto); (2) estado do
repositório — git status, log recente, ausência de conflitos e mudanças pendentes;
(3) estado do ambiente — comandos para verificar dependências, banco/serviços locais
e variáveis de ambiente; (4) prioridade da sessão — confirmar qual é a tarefa
principal, verificar pendências da sessão anterior em changelog_internal.md e decidir
se a tarefa requer Plan Mode; (5) sinais de alerta — situações que exigem parar e
confirmar com o usuário antes de prosseguir; (6) encerramento — lembrete de executar
/project:done ao final.
```

---

## changelog_internal.md — Log de sessões do agente

```text
Crie um arquivo changelog_internal.md que serve como registro cronológico das
mudanças realizadas pelo agente em cada sessão de trabalho. Estrutura de cada entrada:
(1) cabeçalho com data e mensagem de commit no padrão Conventional Commits;
(2) resumo descritivo do que foi feito e por quê — com contexto suficiente para
entender sem consultar o código; (3) lista de arquivos modificados com descrição
da mudança e tipo (Nova Funcionalidade / Correção / Refatoração / Documentação /
Segurança / Infraestrutura); (4) tipo geral da alteração; (5) hash e mensagem do
commit realizado; (6) assinatura do agente; (7) separador visual entre entradas.
Entradas mais recentes no topo. Nunca deletar entradas antigas.
```
