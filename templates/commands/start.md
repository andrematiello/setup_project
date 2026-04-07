<!--
  COMANDO: /project:start
  QUANDO ACIONAR: sempre ao iniciar uma nova sessão, antes de qualquer implementação.
  QUEM ACIONA: usuário explicitamente.
  ETAPAS: [GENÉRICO]
  - Lê CLAUDE.md e documentação obrigatória da sessão
  - Executa verificações de estado: branches, dependências, banco, deploys, erros recentes
  - Reporta estado da aplicação e itens de atenção
  - Grava log da sessão
-->

# /project:start

Rotina de início de sessão. Execute sempre que uma nova sessão começar,
antes de qualquer implementação.

---

## Sequência obrigatória

### 1. Leitura de contexto [GENÉRICO]

Leia nesta ordem:

- `CLAUDE.md` completo
- Arquivos listados em "Leitura Obrigatória" do CLAUDE.md

### 2. Verificações de estado [ADAPTÁVEL]

Execute em paralelo:

- **Branches:** branch atual, mudanças não commitadas (`git status`, `git stash list`)
- **Dependências:** pacotes com atualizações críticas de segurança
- **Banco:** migrations pendentes não aplicadas — se aplicável ao projeto
- **Deploy:** status do último deploy e erros recentes — se aplicável
- **Logs:** erros críticos desde a última sessão — se aplicável

### 3. Relatório de estado [GENÉRICO]

Apresente no chat:

- Resumo do estado da aplicação
- Itens que precisam de atenção antes de começar
- Confirmação: "Contexto carregado. Pronto para trabalhar."

Grave o log em `logs/start/start-[YYYY-MM-DD_HH-mm].md`.

Só então aguarde instruções.
