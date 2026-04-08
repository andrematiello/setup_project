# Business Domain — claude-kit

> Decisões de produto não óbvias, invariantes do sistema e glossário.
> Atualizar sempre que uma decisão de produto for tomada ou alterada.

---

## Produto

**claude-kit** é um instalador de ambiente Claude Code para projetos de software.

Objetivo central: reduzir a zero o tempo de configuração de um agente Claude Code
com comportamento consistente, seguro e adaptado ao projeto.

Entrega: um conjunto de arquivos (commands, rules, skills, settings, CLAUDE.md)
instaláveis em qualquer repositório via `curl | bash`.

---

## Invariantes do sistema

1. **CLAUDE.md nunca é substituído automaticamente.** Em nenhum modo (`--force`, `--update`). É o arquivo mais customizado de qualquer projeto — substituí-lo sem revisão destruiria o trabalho do usuário.

2. **Nenhuma decisão irreversível é tomada sem aprovação explícita.** O `/project:update-kit` nunca salva um arquivo sem o usuário confirmar. A automação vai até onde é seguro — o julgamento final é do usuário.

3. **Segurança é não-negociável.** Em conflitos entre template e local em seções de segurança, o critério padrão é adotar a versão mais restritiva. Se não for óbvio qual é mais restritiva, o agente classifica como CONFLITO e pergunta.

4. **Customizações locais têm precedência sobre templates.** Placeholders preenchidos e conteúdo projeto-específico são sempre preservados no merge, independente do que o template diz.

---

## Decisões de produto

### 2026-04-08 — Merge inteligente via Claude, não via bash

**Contexto:** o modo `--update` precisa lidar com arquivos que têm customizações locais.

**Decisão:** o bash detecta e lista os divergentes; o merge em si é delegado ao Claude Code via `/project:update-kit`.

**Por quê:** merge semântico de markdown requer compreensão de intenção — o que é customização do usuário versus o que é atualização de template. Bash não tem essa capacidade. Claude sim.

**Alternativas descartadas:**
- `diff3` / `patch`: merge textual cego, sem entender contexto ou intenção
- Substituição com backup: perde customizações sem oportunidade de revisão
- Prompt de decisão no bash: limitado a sim/não por arquivo inteiro, sem granularidade

---

### 2026-04-08 — Categorias objetivas de merge no /project:update-kit

**Contexto:** o agente precisa de critérios claros para deliberar sem travar em cada decisão trivial.

**Decisão:** 7 categorias mutuamente exclusivas, com critério padrão para as não-ambíguas:

| Categoria | Critério padrão |
|---|---|
| ADITIVO | Adotar automaticamente |
| MELHORIA | Adotar automaticamente |
| PLACEHOLDER | Preservar sempre |
| PROJETO-ESPECÍFICO | Preservar sempre |
| SEGURANÇA | Adotar a mais restritiva |
| CONFLITO | Perguntar sempre |
| REMOÇÃO | Perguntar sempre |

**Por quê:** o agente só interrompe o usuário quando há ambiguidade real. Decisões claras são tomadas automaticamente e registradas no relatório — o usuário revisa o resultado final, não cada passo trivial.

---

### 2026-04-08 — security-check e security-audit são complementares, não redundantes

**Contexto:** o kit tem dois mecanismos de segurança com nomes similares.

**Decisão:** manter os dois com papéis distintos e não colapsá-los.

- `security-check` (skill passiva): ativa automaticamente ao tocar áreas sensíveis durante implementação. Foco: sinalizar riscos antes de escrever código.
- `security-audit` (skill ativa): invocada explicitamente para auditoria completa. Foco: relatório estruturado com OWASP, CVSS, recomendações priorizadas.

**Por quê:** um guarda na porta não substitui uma auditoria formal — e uma auditoria não substitui o guarda. São camadas diferentes de proteção.

---

### 2026-04-08 — /project:start é executado automaticamente na primeira mensagem

**Contexto:** usuários frequentemente esqueciam de rodar `/project:start` antes de trabalhar, resultando em sessões sem contexto carregado.

**Decisão:** o `CLAUDE.md` template inclui instrução para o Claude executar `/project:start` automaticamente na primeira mensagem de cada sessão.

**Exceção:** se o usuário já iniciar com `/project:start`, o agente não duplica.

**Por quê:** o onboarding de sessão é obrigatório para garantir contexto, segurança e continuidade — não deveria depender de o usuário lembrar de fazê-lo.

---

## Glossário

| Termo | Definição |
|---|---|
| **template** | Arquivo no repositório `setup_project` usado como base para instalação |
| **local** | Arquivo no projeto do usuário, potencialmente customizado |
| **divergente** | Arquivo local que difere do template (customização detectada) |
| **pending** | Arquivo divergente aguardando merge via `/project:update-kit` |
| **merge** | Consolidação inteligente entre template atualizado e customização local |
| **CLAUDE.md** | Especificação comportamental do agente — o arquivo mais importante do kit |
