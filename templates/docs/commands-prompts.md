# Catálogo de Prompts-Semente — /project:commands

> Use este arquivo com o **Prompt Mestre** para regenerar qualquer comando adaptado
> a um novo projeto. Fluxo: Prompt Mestre + prompt-semente → arquivo pronto.
>
> Para cada projeto novo, substitua os itens marcados como [ADAPTÁVEL] nos arquivos gerados.

---

## /project:done

```text
Crie um comando /project:done que encerra uma sessão com alterações, garantindo registro
em changelog, validação de documentação, commit, push e eventuais deploys operacionais.
Ele deve: (1) verificar se a sessão teve modificações reais antes de rodar; (2) adicionar
entrada estruturada em docs/changelog_internal.md com data, resumo, arquivos, tipo e
assinatura do agente; (3) validar e atualizar a documentação afetada antes do commit,
sem presumir consistência; (4) fazer commit em Conventional Commits; (5) avaliar risco
da sessão e, se necessário, acionar /project:deploy-check antes do push; (6) fazer push;
(7) executar deploy de backend/migrations quando aplicável; (8) gerar relatório final
salvo em logs/done/ com status de cada etapa. O comando é acionado pelo usuário
explicitamente ou automaticamente pelo /project:deploy-check ao fim da Fase 1.
```

---

## /project:fix

```text
Crie um comando /project:fix [descrição do bug] para corrigir bugs com método e
rastreabilidade. Ele deve exigir: reprodução do bug com descrição do comportamento
atual vs esperado; identificação de causa raiz antes de qualquer correção; correção
no ponto certo e em todas as ocorrências similares; verificação de que não houve
regressão adjacente. Inclua uma etapa de atualização documental quando o bug revelar
lacuna, e registro especial para bugs de segurança. Finalize com um relatório no chat
contendo causa raiz, arquivos/mudanças e verificações realizadas. O comando é quase
totalmente genérico — o único item adaptável é o arquivo de decisões/postmortems.
```

---

## /project:feature

```text
Crie um comando /project:feature [nome da feature] para implementar novas
funcionalidades com segurança e previsibilidade. Ele deve: ler o contexto e as regras
dos domínios afetados antes de qualquer código; mapear impactos técnicos (arquivos,
banco, políticas de acesso, integrações) e aguardar confirmação do usuário para
prosseguir; implementar em ordem arquitetural obrigatória (banco → tipos → dados →
lógica → componentes → rotas); aplicar checklist de qualidade (políticas de acesso,
estados de UI, tipagem, validação de inputs, limite de tamanho de arquivo); atualizar
a documentação afetada. Finalize com relatório contendo o que foi entregue, o que
ficou pendente e o que precisa ser testado manualmente.
```

---

## /project:review

> Prompt-semente pendente — envie o relatório estruturado de review.md para completar.

---

## /project:refactor

> Prompt-semente pendente — envie o relatório estruturado de refactor.md para completar.

---

## /project:document

> Prompt-semente pendente — envie o relatório estruturado de document.md para completar.

---

## /project:deploy-check

> Prompt-semente pendente — envie o relatório estruturado de deploy-check.md para completar.

---

## /project:release

> Prompt-semente pendente — envie o relatório estruturado de release.md para completar.

---

## /project:start

> Prompt-semente pendente — envie o relatório estruturado de start.md para completar.

---

## /project:setup

> Prompt-semente pendente — envie o relatório estruturado de setup.md para completar.
