# Regras de Auth e Autorização

Leia ao tocar em login, signup, sessão, logout, proteção de rota, roles ou provedor de auth.

## Proteção de rotas

- Toda rota autenticada passa por um guard / middleware de autenticação.
- Para áreas admin: combine o guard com checagem explícita de role.

### Rota autenticada (exemplo genérico)

```tsx
// React
<ProtectedRoute>
  <PaginaProtegida />
</ProtectedRoute>

// Next.js App Router
export default async function Page() {
  const session = await getServerSession()
  if (!session) redirect("/login")
}
```

### Rota admin (exemplo genérico)

```ts
const isAdmin = ["owner", "admin"].includes(user?.role ?? "")
if (!isAdmin) redirect("/unauthorized")
```

## Roles

- Frontend verifica role apenas para UX, navegação e visibilidade de ações.
- Backend e banco fazem a proteção real.
- Nunca trate role no frontend como autorização suficiente para operação sensível.

### Frontend (apenas UX)

```ts
const canManageTeam = ["owner", "admin"].includes(membership?.role ?? "")
```

### Proteção real

- Políticas de acesso no banco para leitura e escrita padrão.
- Endpoint protegido para operações privilegiadas.
- Membership sempre derivado do banco, nunca do cliente.

## Sessão

- A sessão deve viver em um contexto ou store central — não duplicada em múltiplos lugares.
- Exponha: `session`, `user`, `loading` e `signOut` no mínimo.
- Observe mudanças de auth via listener do provedor, não por polling.
- Não implemente logout manual limpando storage sem chamar o provedor.

## Logout correto

- Sempre use a função de `signOut` do provedor de auth.
- `signOut` deve invalidar a sessão no servidor.
- Depois disso, limpe o estado local de sessão e usuário.

## Regras obrigatórias

- Toda rota autenticada passa pelo guard definido no projeto.
- Toda checagem de role usa dados vindos do banco, não do cliente.
- Toda operação destrutiva ou privilegiada valida role no backend.
- Não duplique lógica de sessão fora do contexto/store central.
- Não altere o fluxo de auth sem confirmação explícita.

## Configurações obrigatórias do provedor de auth para produção

- Confirmação de e-mail habilitada (se aplicável ao produto)
- URLs de redirect configuradas para produção e localhost
- Política de recuperação de senha ativa
- Magic link apenas se o fluxo do produto exigir

## Fluxo de autenticação do projeto [ADAPTÁVEL]

```text
/login
-> sessão válida
-> [descrever o fluxo de redirect pós-login do projeto]
```
