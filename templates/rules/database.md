# Regras de Banco de Dados

Leia ao trabalhar com schema, migrations, queries, políticas de acesso ou ORM.

## Regra principal

- Nunca edite migration existente.
- Toda mudança de schema exige nova migration.
- Nome do arquivo: siga o padrão de nomenclatura do ORM/ferramenta do projeto.

## Padrão de query com tratamento de erro

### Correto

```ts
const { data, error } = await db
  .from("items")
  .select("id, title, org_id")
  .eq("org_id", orgId)

if (error) throw error
return data
```

### Incorreto

```ts
const { data } = await db.from("items").select("*")
return data
```

## Migrations

- Toda tabela nova deve ter políticas de acesso habilitadas.
- Toda migration destrutiva exige confirmação explícita.
- Nunca remova coluna, tabela ou política sem revisar impacto.
- Depois de mudar schema, atualize os tipos gerados se o projeto usar geração automática.

## Políticas de acesso (multi-tenant) [ADAPTÁVEL]

Use este padrão base para tabelas com isolamento por tenant:

```sql
CREATE TABLE public.nome_tabela (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  org_id UUID NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

ALTER TABLE public.nome_tabela ENABLE ROW LEVEL SECURITY;

-- Adapte as políticas para o mecanismo de acesso do projeto
CREATE POLICY "Members can select" ON public.nome_tabela
  FOR SELECT USING (is_member(auth.uid(), org_id));

CREATE POLICY "Members can insert" ON public.nome_tabela
  FOR INSERT WITH CHECK (is_member(auth.uid(), org_id));
```

## Quando usar backend privilegiado em vez de query direta

- Quando precisar de credencial de serviço
- Quando houver integração externa
- Quando houver regra de autorização além das políticas
- Quando o fluxo envolver múltiplas tabelas ou efeitos colaterais

## Convenções de nomenclatura [ADAPTÁVEL]

- Tabelas: `snake_case`
- Colunas: `snake_case`
- Foreign keys: `<entidade>_id`
- Índices e constraints: nomes descritivos em `snake_case`
- Funções / procedures: verbo + alvo em `snake_case`
