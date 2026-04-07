# Regras de Componentes React

Leia ao criar, modificar ou refatorar componentes React.

## Regra Absoluta [ADAPTÁVEL]

**Nunca modifique componentes gerenciados por biblioteca de UI** (ex: shadcn/ui, Radix).
Customizações vão via `className` e variantes, nunca editando os primitivos.

---

## Estrutura de Componentes [ADAPTÁVEL]

```
src/components/
├── ui/           ← biblioteca de UI (NUNCA edite manualmente)
├── shared/       ← reutilizáveis em qualquer contexto do app
├── [domínio]/    ← exclusivos de um domínio (daily, library, settings, etc.)
└── layout/       ← shell, header, sidebar, rotas protegidas
```

**Regra:** componente vai em `shared/` se usado em 2+ domínios. Se usado em apenas um, vai na pasta daquele domínio.

---

## Convenções de Código

### TypeScript

```typescript
// Props tipadas explicitamente
interface Props {
  title: string
  onSelect: (id: string) => void
  variant?: "default" | "outline"
}

// Sem any, sem @ts-ignore
```

### Estrutura de componente

```typescript
export function MeuComponente({ title, onSelect }: Props) {
  const [open, setOpen] = useState(false)
  const { data, isLoading } = useMeuHook()

  return (
    <div className={cn("base-classes", open && "conditional-class")}>
      {/* JSX */}
    </div>
  )
}
```

- **Named exports** — nunca `export default` em componentes
- **Componentes funcionais** — sem class components
- **Máximo 300 linhas por arquivo** — se ultrapassar, decomponha
- **Sem lógica de negócio** no componente — extraia para hooks

### Estilos [ADAPTÁVEL]

```typescript
// Correto: cn() para classes condicionais
<div className={cn("flex items-center", isActive && "bg-accent")} />

// Incorreto: template literals para Tailwind condicional
<div className={`flex items-center ${isActive ? "bg-accent" : ""}`} />
```

---

## Padrões de Componente

### Componente que recebe e exibe dados (puro)

```typescript
export function ItemRow({ item, onEdit }: Props) {
  return (
    <div onClick={() => onEdit(item.id)}>
      {item.title}
    </div>
  )
}
```

### Componente conectado a dados

```typescript
export function ItemList() {
  const { items, isLoading } = useItems(org.id)

  if (isLoading) return <Skeleton />
  return items.map(i => <ItemRow key={i.id} item={i} />)
}
```

---

## Ícones [ADAPTÁVEL]

Use a biblioteca de ícones definida no projeto de forma consistente.
Tamanhos padrão: defina e documente no projeto.

---

## Formulários [ADAPTÁVEL]

Use React Hook Form + Zod para todos os formulários:

```typescript
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import { z } from "zod"

const schema = z.object({
  title: z.string().min(1, "Título obrigatório").max(200),
})

const form = useForm({ resolver: zodResolver(schema) })
```

---

## Imports

```typescript
// Sempre absolutos com @/
import { useOrg } from "@/contexts/OrgContext"
import { cn } from "@/lib/utils"

// Nunca relativos longos
import { useOrg } from "../../../contexts/OrgContext"
```
