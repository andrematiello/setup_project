<!--
  COMANDO: /project:fix [descrição do bug]
  QUANDO ACIONAR: ao corrigir qualquer bug — especialmente com causa não óbvia,
  padrão repetido em múltiplos lugares, ou em área sensível (auth, banco, pagamentos).
  QUEM ACIONA: usuário explicitamente.
  ETAPAS: [GENÉRICO]
  - Reproduz o bug e descreve comportamento atual vs esperado
  - Traça o código até a causa raiz (não corrige antes de identificá-la)
  - Aplica correção; verifica padrão em outros lugares
  - Confirma que o bug não reproduz e que o entorno não foi afetado
  - Atualiza docs se necessário; registra em decisions.md se for erro de segurança
-->

# /project:fix $ARGUMENTS

Corrige um bug de forma estruturada.

---

## Sequência

### 1. Reprodução [GENÉRICO]

Identifique exatamente como reproduzir o bug.
Descreva o comportamento atual vs esperado.

### 2. Causa raiz [GENÉRICO]

Trace o código para identificar onde o problema origina.
Verifique se o mesmo padrão existe em outros lugares.

**Não corrija antes de ter a causa raiz clara.**

### 3. Correção [GENÉRICO]

Implemente a correção no local correto.
Se o mesmo padrão existe em outros lugares, corrija todos.
Se o motivo não for óbvio no código, adicione um comentário curto explicando o fix.

### 4. Verificação [GENÉRICO]

Confirme que o bug não reproduz mais.
Verifique que o comportamento adjacente não foi afetado.

### 5. Documentação [ADAPTÁVEL]

Se o bug revelou uma lacuna nas regras ou docs, atualize.
Se foi um erro de segurança, documente em `docs/decisions.md`.

### 6. Relatório [GENÉRICO]

- Causa raiz identificada: [descrição]
- O que foi corrigido: [arquivos e mudanças]
- Verificações feitas: [o que foi testado]
