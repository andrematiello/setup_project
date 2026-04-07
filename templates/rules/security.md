# Regras de Segurança

Leia ao tocar em auth, banco, pagamentos, webhooks, backend ou dados de usuário.

## Nunca pode acontecer

- Nunca use chaves de serviço privilegiadas no frontend.
- Nunca coloque secrets em variáveis públicas de ambiente.
- Nunca confie em `org_id`, `role`, `user_id` ou permissões vindas do cliente.
- Nunca contorne políticas de acesso ao banco como atalho.
- Nunca processe pagamento no client-side.
- Nunca retorne stack trace, SQL error, token, secret ou dados de outro tenant ao cliente.
- Nunca construa SQL concatenando input de usuário.
- Nunca processe webhook sem validar assinatura antes.

## Requer confirmação antes de executar

- Remover tabela, coluna, política ou trigger.
- Tornar endpoint público sem autenticação.
- Criar migration destrutiva.
- Alterar fluxo de auth, RBAC ou isolamento multi-tenant.
- Mudar variáveis de ambiente de produção.

## Variáveis de ambiente

### Públicas (podem ir no frontend)

- URL do serviço de backend
- Chave pública / anon key do banco
- E-mail de suporte ou admin

### Privadas (nunca no frontend)

- Chaves de serviço privilegiadas
- Chaves de webhook
- Tokens de provedores externos
- Qualquer secret de pagamento, e-mail, IA ou OAuth

## Políticas de acesso

- Toda tabela nova deve ter políticas de acesso habilitadas.
- Toda tabela nova deve ter políticas para SELECT, INSERT, UPDATE e DELETE quando aplicável.
- Use funções auxiliares de verificação de membership nas políticas.
- Nunca faça join direto em tabela de memberships dentro de política.
- Toda operação multi-tenant deve ser isolada por `org_id` / `tenant_id`.

## Input e queries

- Valide todo input externo antes de processar.
- Nunca concatene SQL com string de usuário.
- Use UUIDs, e-mails, limites de tamanho e enums na validação.

### Correto

```ts
const schema = z.object({ orgId: z.string().uuid(), title: z.string().max(200) })
const parsed = schema.safeParse(body)
if (!parsed.success) return badRequest()
```

### Incorreto

```ts
const orgId = body.orgId
const sql = `select * from items where org_id = '${orgId}'`
```

## Webhooks

- Valide assinatura antes de parsear ou processar.
- Rejeite payload inválido com `401` ou `400`.
- Implemente idempotência quando o provedor puder reenviar eventos.
- Nunca exponha o segredo do webhook em log ou resposta.

## Checklist pré-produção

### Auth e acesso

- [ ] Token/JWT validado antes de acessar dados protegidos
- [ ] Membership / role validado a partir do banco
- [ ] Roles verificadas em operações privilegiadas

### Banco

- [ ] Políticas de acesso ativas em toda tabela nova
- [ ] Políticas corretas para cada operação
- [ ] Nenhuma migration destrutiva sem confirmação

### Inputs e respostas

- [ ] Validação em todo input externo
- [ ] Sem SQL concatenado
- [ ] Sem erro interno exposto ao cliente

### Secrets e integrações

- [ ] Nenhum secret em variável pública
- [ ] Webhook com assinatura validada
- [ ] Logs sem tokens, senhas ou dados sensíveis
