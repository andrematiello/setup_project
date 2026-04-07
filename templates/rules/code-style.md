# Convenções de Código do Projeto

Leia ao criar, mover ou revisar código.

## Nomenclatura

- Componentes React: `PascalCase.tsx`
- Hooks: `useCamelCase.ts` ou `useCamelCase.tsx`
- Utilitários: `kebab-case.ts`
- Páginas: `PascalCase.tsx`
- Variáveis e funções: `camelCase` em inglês
- Tipos e interfaces: `PascalCase`
- Textos para usuário: idioma definido no projeto

## Estrutura interna de componente

Ordem preferida:

1. imports
2. tipos e props
3. export do componente
4. estado local
5. contextos
6. hooks de dados
7. valores derivados
8. handlers
9. JSX

### Exemplo

```tsx
type Props = { title: string }

export function ExampleCard({ title }: Props) {
  const [open, setOpen] = useState(false)
  const { org } = useOrg()
  const { data, isLoading } = useExampleQuery(org?.id)

  function handleOpen() {
    setOpen(true)
  }

  return <div>{title}</div>
}
```

## Padrões de hooks

- Hooks de query ficam em `src/hooks/`
- `queryKey` inclui `orgId` / `tenantId` quando o dado é multi-tenant
- Use `enabled: !!orgId` quando a query depende do tenant
- `useMutation` deve invalidar queries afetadas em `onSettled`
- Componentes não concentram lógica de negócio que cabe ao hook

### useQuery

```ts
useQuery({
  queryKey: ["items", orgId, filters],
  queryFn: () => fetchItems(orgId, filters),
  enabled: !!orgId,
})
```

### useMutation

```ts
useMutation({
  mutationFn: createItem,
  onSettled: () => {
    queryClient.invalidateQueries({ queryKey: ["items", orgId] })
  },
})
```

## TypeScript

- Sem `any`
- Sem `@ts-ignore`
- Prefira narrowing e unions a casts amplos
- Use `import type` para tipos puros
- Extraia tipo utilitário quando a mesma forma aparecer mais de uma vez

## Commits

Formato:

```text
tipo(escopo): descrição curta

Detalhe opcional do que foi feito e por quê.

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
```

Tipos: `feat` | `fix` | `refactor` | `docs` | `style` | `test` | `chore`

## Nunca fazer

### Não usar import relativo profundo

```ts
// Errado
import { useOrg } from "../../../contexts/OrgContext"

// Correto
import { useOrg } from "@/contexts/OrgContext"
```

### Não colocar lógica de negócio em componente

```tsx
// Errado
export function ItemsPage() {
  async function create() {
    // regra de negócio inteira aqui
  }
}

// Correto
export function ItemsPage() {
  const { createItem } = useItems()
}
```

### Não usar `default export` em componentes novos

```tsx
// Errado
export default function ItemCard() {}

// Correto
export function ItemCard() {}
```
