<!--
  COMANDO: /project:review [arquivo | pasta | "últimas mudanças"]
  QUANDO ACIONAR: antes de aprovar código para merge, após feature ou fix relevante.
  QUEM ACIONA: usuário explicitamente.
  ETAPAS: [GENÉRICO]
  - Segurança (prioridade máxima)
  - Correção
  - Qualidade de código
  - Performance
  - Consistência com padrões do projeto
  - Relatório por severidade + veredicto
-->

# /project:review $ARGUMENTS

Code review estruturado por dimensões.

---

## Escopo [GENÉRICO]

Se `$ARGUMENTS` for arquivo: revisar o arquivo.
Se for pasta: revisar todos os arquivos relevantes.
Se for "últimas mudanças": executar `git diff HEAD` e analisar.

---

## Dimensões de análise

### 1. Segurança (prioridade máxima) [GENÉRICO]

- Dados sensíveis expostos no frontend?
- Políticas de acesso configuradas onde necessário?
- Inputs validados antes de ir ao banco ou serviço externo?
- Secrets em variáveis públicas de ambiente?
- Dados de outros tenants / usuários acessíveis indevidamente?

### 2. Correção [GENÉRICO]

- Tratamento de erro em todas as chamadas async?
- Loading, error e empty states implementados?
- Edge cases cobertos?

### 3. Qualidade de código [GENÉRICO]

- TypeScript sem `any`?
- Funções com responsabilidade única?
- Nomes claros e descritivos?
- Arquivos dentro do limite de linhas do projeto?

### 4. Performance [GENÉRICO]

- Queries desnecessariamente amplas?
- Re-renders ou recálculos desnecessários?
- Assets sem lazy loading?

### 5. Consistência [ADAPTÁVEL]

- Segue padrões de `docs/contributing.md`?
- Componentes no lugar correto da hierarquia?
- Usa utilitários e abstrações existentes ou duplicou código?

---

## Formato do relatório [GENÉRICO]

Para cada problema encontrado:

**[CRÍTICO / IMPORTANTE / SUGESTÃO]** `arquivo:linha`
Problema: [descrição]
Solução: [código corrigido ou orientação]

## Sumário executivo [GENÉRICO]

Total por severidade + recomendação:
APROVADO / APROVADO COM RESSALVAS / PRECISA DE MUDANÇAS
