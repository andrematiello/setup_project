<!--
  COMANDO: /project:update-kit
  QUANDO ACIONAR: após rodar setup.sh --update e existir .claude/update-pending.txt
  QUEM ACIONA: usuário explicitamente, após atualização do claude-kit.
  ETAPAS:
  1. Verificação  — confirmar pending list e listar arquivos
  2. Análise      — classificar cada bloco de diferença por tipo
  3. Merge        — consolidar arquivo por arquivo, decisão por decisão
  4. Confirmação  — apresentar resultado e aguardar aprovação antes de salvar
  5. Limpeza      — remover pending list após conclusão
-->

# /project:update-kit

Consolida arquivos do claude-kit que foram atualizados no repositório remoto
mas têm customizações locais. Processa **um arquivo por vez**, **uma decisão
por vez**. Nunca avança sem aprovação explícita do usuário.

---

## 0. Pré-requisito

Leia `.claude/update-pending.txt`.

**Se não existir ou estiver vazio:**
- Informe: "Nenhum arquivo pendente de merge. Kit já está atualizado."
- Encerre o comando.

**Se existir:** cada linha tem o formato `local_path|remote_path`.

Liste os arquivos pendentes e informe quantos são. Exemplo:

```
3 arquivos precisam de merge:
  1. .claude/commands/start.md
  2. .claude/rules/security.md
  3. .claude/settings.json

Começamos pelo primeiro? (s/N)
```

Aguarde confirmação antes de iniciar.

---

## 1. Para cada arquivo da lista

Processe **um arquivo por vez**. Só avance para o próximo após aprovação
explícita no atual.

### 1.1 Leitura

- Leia o arquivo local (`local_path`) completo
- Baixe o template remoto: `https://raw.githubusercontent.com/andrematiello/setup_project/main/{remote_path}`
- Gere um diff interno para mapear as diferenças bloco a bloco

### 1.2 Classificação das diferenças

Para cada bloco divergente, classifique em uma destas categorias:

| Categoria | Quando ocorre | Critério padrão |
|---|---|---|
| `ADITIVO` | Seção ou item existe no template mas não no local | Adotar automaticamente |
| `PLACEHOLDER` | Local preencheu um `[definir]` com conteúdo real | Preservar sempre |
| `PROJETO-ESPECÍFICO` | Local tem stack, URLs, nomes, regras do projeto | Preservar sempre |
| `MELHORIA` | Template atualizou seção que o local não tocou | Adotar, registrar o que mudou |
| `SEGURANÇA` | Mudança em regra de segurança, auth, acesso, RLS | Adotar a versão mais restritiva |
| `CONFLITO` | Template e local divergem na mesma seção com intenções diferentes | Deliberar → perguntar |
| `REMOÇÃO` | Template removeu algo que ainda existe no local | Perguntar antes de remover |

**Em caso de dúvida sobre a categoria:** classifique como `CONFLITO` e apresente
ao usuário. Nunca decida silenciosamente em casos ambíguos.

### 1.3 Aplicação dos critérios

**ADITIVO e MELHORIA — adote automaticamente:**
- Incorpore o conteúdo novo no arquivo consolidado
- Registre no relatório: `adotado do template`
- Não pergunte — siga

**PLACEHOLDER e PROJETO-ESPECÍFICO — preserve sempre:**
- Mantenha o conteúdo local intacto
- Registre no relatório: `preservado (customização local)`
- Não pergunte — siga

**SEGURANÇA — adote a versão mais restritiva:**
- Compare as duas versões e identifique qual impõe mais restrições
- Se não for óbvio qual é mais restritiva: reclassifique como `CONFLITO`
- Registre no relatório: `adotado (critério segurança — versão mais restritiva)`
- Informe ao usuário o que mudou ao apresentar o resultado final

**CONFLITO — apresente e pergunte:**

```
─── CONFLITO: [nome do arquivo] → [nome da seção]

TEMPLATE:
[conteúdo exato do template]

LOCAL:
[conteúdo exato do local]

Análise: [explique em 2-3 linhas o que cada versão prioriza
          e qual o impacto de escolher uma ou outra]

Opções:
  A) Manter o local
  B) Adotar o template
  C) Consolidar — descreva o que quer manter de cada lado
  D) Pular por agora e decidir depois
```

Aguarde resposta. Se C: escreva a versão consolidada e apresente para aprovação.
Se D: registre na pending list como `PENDENTE` e siga para o próximo bloco.

**REMOÇÃO — apresente e pergunte:**

```
─── REMOÇÃO: [nome do arquivo] → [nome da seção]

O template removeu esta seção. Local ainda contém:
[conteúdo que seria removido]

Possível motivo: [sua análise — foi substituído, ficou obsoleto, foi movido?]

Manter ou remover?
  A) Manter (preservar customização local)
  B) Remover (alinhar com template)
```

Aguarde resposta antes de continuar.

### 1.4 Resultado consolidado do arquivo

Após processar todos os blocos do arquivo:

1. Monte o arquivo consolidado completo
2. Apresente ao usuário:

```
─── RESULTADO: [nome do arquivo]

[conteúdo consolidado completo]

─── Resumo das decisões:
  ✓ 2 seções adotadas do template (ADITIVO)
  ✓ 1 customização preservada (PROJETO-ESPECÍFICO)
  ✓ 1 conflito resolvido (opção C — consolidado)
  ⚠ 1 item de segurança atualizado para versão mais restritiva

Salvar este arquivo? (s/N)
```

3. Aguarde aprovação explícita
4. **Se aprovado:** salve o arquivo e avance para o próximo
5. **Se rejeitado:** pergunte se quer revisar algum bloco específico ou pular

---

## 2. Relatório final

Após processar todos os arquivos da lista:

```markdown
## Update-kit concluído — [YYYY-MM-DD HH:mm]

| Arquivo | Status | Decisões |
|---|---|---|
| .claude/commands/start.md | ✅ consolidado | 3 aditivos, 1 conflito resolvido |
| .claude/rules/security.md | ✅ consolidado | 1 segurança (mais restritiva) |
| .claude/settings.json     | ⏭ pulado | usuário optou por revisar depois |
```

Se todos foram aprovados: remova `.claude/update-pending.txt`.

Se algum foi pulado: mantenha apenas as linhas pendentes no arquivo.

Informe o estado final:
- "Kit totalmente atualizado." → se nenhum pendente restou
- "X arquivo(s) ainda pendente(s) em .claude/update-pending.txt" → se restou algo
