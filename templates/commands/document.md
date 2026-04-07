<!--
  COMANDO: /project:document [modo]
  QUANDO ACIONAR: ao criar ou atualizar documentação após implementação,
  refatoração ou decisão arquitetural.
  QUEM ACIONA: usuário explicitamente.
  MODOS: completo | README | feature [nome] | decisões
  ETAPAS: [ADAPTÁVEL]
  - Lê estrutura real do código (não assume)
  - Marca fatos como [CONFIRMADO] ou [INFERIDO]
  - Apresenta mapeamento antes de reescrever docs principais
  - Pergunta ao final o que está incorreto ou faltando
-->

# /project:document $ARGUMENTS

Gera ou atualiza documentação.

---

## Modos

### `completo` [ADAPTÁVEL]

1. Leia a estrutura real de `src/`, banco, `docs/` e arquivos de configuração
2. Mapeie: entidades, fluxos, integrações, variáveis de ambiente, rotas e ambiguidades
3. Apresente o mapeamento ao usuário e aguarde confirmação antes de reescrever
4. Gere ou atualize: `README.md`, `docs/architecture.md`, `docs/data-model.md`,
   `docs/integrations.md`, `docs/decisions.md` e `CLAUDE.md` para revisão
5. Marque `[INFERIDO]` para interpretações e `[CONFIRMADO]` para fatos observáveis no código

### `README` [GENÉRICO]

Gere `README.md` com foco humano e onboarding rápido:

- Descrição objetiva do produto
- Stack tecnológica
- Pré-requisitos
- Instalação passo a passo
- Variáveis de ambiente com referência a `.env.example`
- Estrutura resumida de pastas
- Fluxos principais do produto
- Comandos úteis

### `feature [nome]` [ADAPTÁVEL]

Localize a feature por nome em `src/` e `docs/`.
Gere ou atualize a documentação mais adequada:

- Preferencialmente em `docs/features.md`
- Se já existir documentação dedicada, atualize esse arquivo

Documente:

- Propósito
- Entidades envolvidas
- Fluxo principal
- Dependências
- Decisões não óbvias

Marque `[INFERIDO]` e `[CONFIRMADO]`.

### `decisões` [ADAPTÁVEL]

Analise o código em busca de padrões arquiteturais reais.
Para cada decisão, adicione entrada em `docs/decisions.md` com:

- Contexto
- Decisão
- Alternativas
- Consequências

---

## Após gerar [GENÉRICO]

Sempre pergunte: "O que está incorreto ou faltando?"
