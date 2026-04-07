# Regras de TypeScript

Leia ao criar ou alterar arquivos TypeScript.

## Proibições absolutas

- Nunca usar `any`.
- Nunca usar `@ts-ignore`.
- Nunca usar `@ts-expect-error` como atalho.
- Nunca usar `as` sem necessidade real.
- Nunca usar `!` para contornar nulidade sem garantia estrutural.

## Tipos utilitários preferidos

- `Partial<T>` para updates parciais
- `Pick<T, K>` para subconjuntos de campos
- `Omit<T, K>` para remover campos sensíveis ou irrelevantes
- `Record<K, V>` para mapas tipados

```ts
type ItemPreview = Pick<Item, "id" | "title" | "date">
type ItemUpdate = Partial<Pick<Item, "title" | "status">>
type PublicProfile = Omit<Profile, "phone">
type RoleLabels = Record<UserRole, string>
```

## Props de componente

- Defina um tipo ou interface `Props`.
- Tipos de props ficam acima do componente.
- Use `children?: React.ReactNode` apenas quando necessário.

```tsx
type Props = {
  title: string
  onSelect: (id: string) => void
  children?: React.ReactNode
}

export function ExampleCard({ title, onSelect, children }: Props) {
  return <div>{title}{children}</div>
}
```

## Retorno de hooks

- Prefira objeto nomeado a tuple quando houver mais de dois valores.
- Tipos de retorno explícitos são preferidos em hooks com API pública reutilizável.

```ts
type UseItemsResult = {
  items: Item[]
  isLoading: boolean
  createItem: (input: ItemInsert) => Promise<void>
}

export function useItems(orgId: string): UseItemsResult {
  // ...
}
```

## Exportar tipos

- Use `export type` para aliases.
- Use `export interface` quando a interface precisar ser estendida.
- Use `import type` para imports puramente tipados.

```ts
export type { ItemPreview, ItemUpdate }
import type { Database } from "@/types/database"
```

## Funções assíncronas

- Tipar retorno com `Promise<T>`.
- Não deixar função async pública inferir `Promise<any>`.

```ts
async function fetchProfile(userId: string): Promise<Profile | null> {
  // ...
}
```

## Event handlers

- Tipar eventos com os tipos do React.
- Nomear handlers com `handle`.

```tsx
function handleSubmit(event: React.FormEvent<HTMLFormElement>) {
  event.preventDefault()
}

function handleChange(event: React.ChangeEvent<HTMLInputElement>) {
  setValue(event.target.value)
}
```
