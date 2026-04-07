# Regras de Testes

Leia ao criar, modificar ou avaliar testes.

## Stack de Testes [ADAPTÁVEL]

- **Framework:** Vitest (padrão) — substitua pelo do projeto se diferente
- **Utilitários:** `@testing-library/react` para hooks com estado
- **Imports:** sempre do framework escolhido — não misture jest e vitest
- **Executar:** `[PKG_MANAGER] run test`

---

## O que testar

### Testar obrigatoriamente

- Funções puras em `src/lib/` — parsers, helpers, validações, formatadores
- Hooks críticos com lógica de segurança ou lógica de negócio complexa
- Transições de estado não triviais
- Casos de borda: null, undefined, string vazia, array vazio, datas inválidas

### Não testar

- Componentes React simples (renderização visual)
- Chamadas ao banco que requerem ambiente real
- Funções serverless / edge (testadas manualmente ou em integração)
- Comportamento já garantido pelo TypeScript

---

## Estrutura de arquivo de teste

```typescript
// Localização: mesmo diretório do arquivo testado
// Nomenclatura: [nome-do-arquivo].test.ts

import { describe, it, expect, vi, beforeEach, afterEach } from "vitest"
import { funcaoTestada } from "./funcao-testada"

describe("funcaoTestada", () => {
  it("retorna X quando Y", () => {
    expect(funcaoTestada(input)).toBe(expected)
  })
})
```

---

## Nomenclatura

```typescript
// describe: nome da função ou hook
describe("parseQuickAdd", () => { ... })
describe("usePinLock", () => { ... })

// describe aninhado: contexto do cenário
describe("usePinLock — setup de PIN", () => { ... })

// it: frase descritiva do comportamento esperado
it("retorna null para input vazio", () => { ... })
it("começa desativado quando não há dado salvo", () => { ... })
```

---

## Casos obrigatórios por teste

1. **Happy path** — entrada válida, resultado esperado
2. **Entrada inválida ou vazia** — null, undefined, string vazia, array vazio
3. **Casos de borda** — limite mínimo, máximo, valores inesperados
4. **Comportamento negativo** — o que NÃO deve acontecer

---

## Mocks

```typescript
// Usar vi.useFakeTimers() para testes de tempo
beforeEach(() => { vi.useFakeTimers() })
afterEach(() => { vi.useRealTimers() })

// vi.fn() para callbacks
const onSave = vi.fn()

// localStorage: limpar antes de cada teste
beforeEach(() => { localStorage.clear() })

// Não mockar o banco — testes com banco são integração, não unitários
// Não mockar funções puras — testá-las diretamente é o ponto
```

---

## Hooks com estado (`renderHook`)

```typescript
import { renderHook, act } from "@testing-library/react"

const { result } = renderHook(() => useHook(params))

expect(result.current.value).toBe(expected)

await act(async () => {
  await result.current.doSomething()
})

expect(result.current.value).toBe(newExpected)
```

---

## Cobertura mínima esperada

| Camada | Cobertura mínima |
| --- | --- |
| `src/lib/` — funções puras | 100% das funções exportadas |
| Hooks críticos | Happy path + casos de erro |
| Parsers e validadores | Todos os casos documentados |

Não existe meta de % de cobertura — existe meta de confiança: cada teste deve cobrir algo que, se quebrar, importa.
