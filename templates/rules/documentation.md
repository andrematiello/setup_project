# Regras de Documentação

Leia ao implementar qualquer mudança que afete comportamento, estrutura ou regras do projeto.

---

## CHANGELOG.md

Atualize `CHANGELOG.md` na raiz **sempre** que a sessão incluir:

- Nova funcionalidade
- Correção de bug
- Mudança de comportamento de comandos, rules ou skills
- Adição ou remoção de arquivo de template
- Alteração no `setup.sh` ou `README.md`

**Não crie entrada para:** ajustes de formatação, typos em comentários ou mudanças sem efeito externo.

### Formato obrigatório

```markdown
## [versão ou "Não lançado"] — YYYY-MM-DD

### Adicionado
- Descrição do que foi adicionado

### Alterado
- Descrição do que mudou de comportamento

### Corrigido
- Descrição do bug corrigido

### Removido
- Descrição do que foi removido
```

Regras:
- Entradas mais recentes no topo
- Uma linha por mudança — objetiva e orientada ao usuário do kit, não ao código interno
- Use a seção `[Não lançado]` enquanto não houver tag de release

---

## docs/business-domain.md [ADAPTÁVEL]

Atualize quando a mudança tocar:

- Regras de negócio do produto
- Invariantes do sistema (o que sempre deve ser verdade)
- Fluxos de estado de entidades (ex: pedido, assinatura, tarefa)
- Glossário do domínio — novo termo ou redefinição de existente
- Decisão de produto não óbvia que foi implementada

**Não atualize** para mudanças puramente técnicas sem impacto no comportamento do produto.

Se `docs/business-domain.md` não existir, crie antes de registrar a mudança.

---

## README.md

Atualize quando:

- Um novo comando for adicionado ou removido do kit
- A instalação ou os pré-requisitos mudarem
- A estrutura instalada pelo `setup.sh` mudar
- A descrição do que o kit faz deixar de refletir a realidade

**Não atualize** para mudanças internas de template que não alteram a experiência de instalação ou uso.

---

## Ordem de execução ao encerrar sessão

1. Atualizar `CHANGELOG.md` (sempre que aplicável)
2. Atualizar `docs/business-domain.md` (quando regra de negócio mudou)
3. Atualizar `README.md` (quando interface pública mudou)
4. Commit e push

**Não faça commit com documentação desatualizada.**
