<!--
  COMANDO: /project:feature [nome da feature]
  QUANDO ACIONAR: ao implementar qualquer nova funcionalidade.
  QUEM ACIONA: usuário explicitamente.
  ETAPAS:
  - Lê contexto e regras dos domínios afetados [GENÉRICO]
  - Mapeia impacto e aguarda confirmação [GENÉRICO]
  - Implementa na ordem: banco → tipos → dados → lógica → UI [ADAPTÁVEL]
  - Checklist de qualidade [ADAPTÁVEL]
  - Atualiza documentação afetada [GENÉRICO]
-->

# /project:feature $ARGUMENTS

Implementa uma nova feature de forma estruturada.

---

## Sequência

### 1. Contexto [GENÉRICO]

Leia `CLAUDE.md` e identifique quais domínios a feature toca.
Leia os arquivos `.claude/rules/` dos domínios afetados.
Leia `docs/business-domain.md` para entender regras de negócio relevantes.

### 2. Mapeamento de impacto [GENÉRICO]

Apresente ao usuário antes de qualquer código:

- Arquivos existentes que serão modificados
- Arquivos novos que serão criados
- Se precisa de migration no banco
- Se há impacto em políticas de acesso existentes
- Se há impacto em integrações externas

**Aguarde confirmação para prosseguir.**

### 3. Implementação [ADAPTÁVEL]

Implemente nesta ordem obrigatória:

1. Migration de banco (se necessário)
2. Tipos e interfaces
3. Funções de acesso a dados (`lib/`, serviços, integrações)
4. Lógica de negócio
5. Hooks / composables / stores
6. Componentes de UI
7. Integração nas rotas e páginas

### 4. Checklist de qualidade [ADAPTÁVEL]

- [ ] Políticas de acesso configuradas para dados novos
- [ ] Loading, error e empty states implementados
- [ ] Sem `any` no TypeScript
- [ ] Sem `console.log` de dados sensíveis
- [ ] Arquivos dentro do limite de linhas definido no projeto
- [ ] Inputs validados

### 5. Documentação [GENÉRICO]

Atualize os docs afetados conforme o que foi implementado.

### 6. Relatório [GENÉRICO]

Apresente:

- O que foi implementado
- O que ficou pendente
- O que o usuário precisa testar manualmente
