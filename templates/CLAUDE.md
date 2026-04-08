# CLAUDE.md — [NOME DO PROJETO]

> Leia este arquivo completo antes de qualquer ação.
> Em caso de dúvida, pergunte antes de executar.
> Gerado por /project:setup — ajuste conforme o projeto evoluir.

---

## Produto

[NOME DO PROJETO] é um [tipo: SaaS / API / ferramenta interna / biblioteca / etc.] que [descrição em uma frase do que faz e para quem].

Stack: [framework frontend] + [linguagem] + [banco/ORM] + [auth] + [UI] + [gerenciador de pacotes]
Deploy: [plataforma] → [URL de produção ou "não definida"]

---

## Leitura Obrigatória — Antes de Qualquer Sessão

Leia nesta ordem antes de começar qualquer trabalho:

1. `[definir: arquivo de arquitetura]` — visão sistêmica do projeto
2. `[definir: arquivo de fluxo de dados]` — como os dados se movem entre camadas
3. `.claude/rules/security.md` — fronteiras de segurança operacional

> Se os arquivos acima ainda não existirem, siga com o contexto disponível.

---

## Leitura Sob Demanda

| Domínio | Arquivo |
| --- | --- |
| Banco / migrations / acesso | `.claude/rules/database.md` |
| Autenticação / autorização | `.claude/rules/auth.md` |
| Componentes / UI | `.claude/rules/components.md` |
| TypeScript | `.claude/rules/typescript.md` |
| Testes | `.claude/rules/testing.md` |
| Estilo de código / commits | `.claude/rules/code-style.md` |
| Documentação (changelog, business, README) | `.claude/rules/documentation.md` |
| [definir: domínio específico do projeto] | `[definir: arquivo]` |

---

## Regras Absolutas

1. [definir — ex: "Nunca edite migration existente — sempre crie nova"]
2. [definir — ex: "Nunca coloque secrets em variáveis públicas de ambiente"]
3. [definir — ex: "Nunca processe pagamento no client-side"]
4. [definir — ex: "Nunca delete arquivos, tabelas ou colunas sem confirmação explícita"]
5. [definir — ex: "Nunca contorne políticas de acesso ao banco como atalho"]

---

## Estrutura de Pastas

```
[adaptar conforme o projeto — exemplo genérico:]

src/
├── components/   ← componentes de UI por domínio
├── pages/        ← páginas e rotas
├── hooks/        ← data fetching e lógica reutilizável
├── lib/          ← utilitários puros
├── types/        ← tipos TypeScript compartilhados
└── ...

docs/             ← documentação técnica viva
.claude/
├── commands/     ← protocolo operacional do agente
├── rules/        ← regras por domínio
└── skills/       ← skills automáticas
```

---

## Padrões de Código

- [definir — ex: "TypeScript estrito — sem any, sem @ts-ignore"]
- [definir — ex: "Named exports em componentes — sem default export"]
- [definir — ex: "PascalCase para componentes, kebab-case para utilitários"]
- [definir — ex: "Máximo 300 linhas por arquivo"]
- [definir — ex: "Imports absolutos com @/"]
- [definir — ex: "Estado assíncrono via React Query"]
- [definir — ex: "Textos ao usuário em Português (Brasil); variáveis em inglês"]
- Commits: [definir — ex: "Conventional Commits em PT-BR"]

---

## Escopo de Mudanças

Faça apenas o que foi pedido. Não melhore o entorno.

**Proibido sem solicitação explícita:**

- Refatorar código adjacente ao que foi pedido
- Adicionar tratamento de erro para cenários que não existem no fluxo real
- Criar abstrações para uso único
- Adicionar comentários ou docstrings em código não tocado
- Propor melhorias de performance ou DX fora do escopo da tarefa
- Adicionar feature "enquanto está aqui"

**Sinal de alerta:** se você está editando mais de 3 arquivos para uma correção pontual, pare e confirme se o escopo está correto.

---

## Comportamento do Agente

### PARE e aguarde resposta antes de executar

[definir — exemplos:]

- Qualquer alteração em autenticação, sessão ou fluxo de login
- Alterar ou criar políticas de acesso ao banco
- Qualquer migration, mesmo simples
- Qualquer operação destrutiva (deletar arquivo, tabela, coluna, registro)
- Mudança em módulo usado por mais de um domínio
- Alteração em variáveis de ambiente de produção
- [definir: áreas sensíveis específicas do projeto]

### EXECUTE sem perguntar

[definir — exemplos:]

- Criar componente novo em pasta de domínio correto
- Corrigir bug visual isolado sem efeito em dados
- Ajustar estilos ou layout
- Criar novo hook de query seguindo padrão existente
- Corrigir erro de tipo sem alterar lógica
- Atualizar documentação para refletir mudança implementada

**Regra prática:** se a mudança não toca auth, banco, pagamentos ou módulos compartilhados — execute e documente o que fez.

### Conflito entre código e documentação

Quando divergirem:

1. **PARE** — não escolha um lado por conta própria
2. **IDENTIFIQUE** com precisão: o que o código faz (arquivo + linha) e o que a doc afirma
3. **REPORTE** ao usuário antes de qualquer ação
4. **AGUARDE** a resposta
5. **APÓS RESOLUÇÃO:** corrija o código ou a doc como parte da mesma tarefa

---

## Preferências de Sessão

### Comunicação

- Idioma: [definir — ex: "Português do Brasil"]
- Verbosidade: [definir — ex: "Respostas diretas e objetivas, sem introduções longas"]
- Planejamento: [definir — ex: "Plan mode para mudanças arquiteturais; execução direta para bugs isolados"]

### Atalhos de linguagem

[definir — ex:]
- "revisa isso" → code review com foco em segurança, correção e performance
- "limpa isso" → remover código morto e simplificar
- "ta bom?" → verificar aderência aos padrões do projeto

### Ambiente local

- SO / shell: [definir — ex: "macOS / zsh" ou "Windows / Git Bash"]
- Editor: [definir — ex: "VS Code"]
- Gerenciador de pacotes: [detectado automaticamente — ex: bun / npm / pnpm / yarn]

---

## Conclusão de Tarefa

Ao finalizar trabalho com alterações em arquivos ou sistema, execute `/project:done`.
