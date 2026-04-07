# Security Check

## Descrição

Ative quando a implementação tocar autenticação, banco de dados, pagamentos, variáveis de ambiente, dados de usuário, APIs externas ou webhooks.

## Procedimento

1. Verifique o checklist de segurança relevante antes de escrever código.
2. Para auth: valide proteção de rota, sessão, logout e checagem de permissão.
3. Para banco: valide isolamento por tenant/usuário, políticas de acesso e impacto multi-tenant.
4. Para APIs e backend: valide autenticação, autorização, validação de input (Zod ou equivalente) e resposta segura.
5. Para variáveis de ambiente e integrações: valide separação entre público e privado.
6. Para webhooks: valide assinatura antes de processar.
7. Sinalize riscos, bloqueios e decisões sensíveis ao usuário antes de implementar.

## Nunca fazer

- Nunca deixar a revisão de segurança para depois do código.
- Nunca seguir com risco crítico sem avisar o usuário.
- Nunca assumir que frontend resolve proteção real.
