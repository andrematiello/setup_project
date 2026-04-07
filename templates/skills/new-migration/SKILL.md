# New Migration

## Descrição

Ative quando o pedido envolver alterar schema do banco: adicionar ou remover coluna, criar tabela, alterar tipo de campo, adicionar índice, modificar política de acesso ou qualquer mudança de schema versionado.

## Procedimento

1. Leia `.claude/rules/database.md` antes de qualquer ação.
2. Verifique se a mudança é destrutiva. Se for, pare e peça confirmação explícita.
3. Crie uma nova migration seguindo o padrão de nomenclatura do projeto. [ADAPTÁVEL]
4. Verifique impacto nas políticas de acesso existentes e ajuste o necessário.
5. Aplique a migration com o comando apropriado ao projeto. [ADAPTÁVEL]
6. Atualize os tipos gerados automaticamente, se o projeto usar geração automática. [ADAPTÁVEL]
7. Informe ao usuário quais tabelas, colunas, políticas e tipos foram afetados.

## Nunca fazer

- Nunca editar migration existente.
- Nunca criar tabela nova sem políticas de acesso (RLS ou equivalente).
- Nunca alterar schema sem revisar impacto em isolamento multi-tenant e queries existentes.
