# CLAUDE.md — [NOME DO PROJETO]

> Leia este arquivo completo antes de qualquer ação.
> Em caso de dúvida, pergunte antes de executar.
> Gerado por claude-kit — personalize conforme o projeto.

---

## Produto e Stack

[NOME] é um [TIPO: SaaS / API / CLI / library].
Stack: [FRAMEWORK] + [BANCO] + [DEPLOY]
Deploy: [PLATAFORMA] → [URL de produção, se houver]

---

## Leitura Obrigatória — Toda Sessão

Leia nesta ordem antes de começar qualquer trabalho:

1. `docs/architecture.md` — visão sistêmica do projeto
2. `docs/data-flow.md` — como dados se movem entre camadas
3. `docs/business-domain.md` — regras de negócio e invariantes
4. `.claude/rules/security.md` — fronteiras de segurança operacional

---

## Leitura Sob Demanda

| Domínio | Arquivo |
| --- | --- |
| Banco / migrations | `.claude/rules/database.md` |
| Autenticação / autorização | `.claude/rules/auth.md` |
| Componentes / UI | `.claude/rules/components.md` |
| Pagamentos | `.claude/rules/payments.md` |
| TypeScript | `.claude/rules/typescript.md` |
| Testes | `.claude/rules/testing.md` |
| Estilo de código / commits | `.claude/rules/code-style.md` |

---

## Regras Absolutas

1. Nunca edite migration existente — sempre crie nova
2. Nunca coloque secrets em variáveis públicas de ambiente
3. Nunca processe pagamento no client-side
4. Nunca delete arquivos, tabelas ou colunas sem confirmação explícita
5. Nunca contorne políticas de acesso ao banco como atalho
6. Nunca use chaves de serviço privilegiadas no frontend

---

## Estrutura de Pastas

- `src/` — código fonte principal
- `src/components/` — componentes de UI
- `src/hooks/` — lógica reutilizável e data fetching
- `src/lib/` — utilitários puros
- `src/pages/` ou `src/app/` — páginas e rotas
- `docs/` — documentação viva do sistema
- `.claude/` — configuração do agente

---

## Padrões de Código

- TypeScript estrito — sem `any`, sem `@ts-ignore`
- Named exports em componentes — sem `default export`
- Máximo 300 linhas por arquivo
- Imports absolutos com `@/`
- Estado assíncrono via React Query / SWR — sem fetch direto em componentes
- Textos ao usuário em [IDIOMA_UX]; variáveis e funções em inglês
- Commits: Conventional Commits

---

## Comportamento do Agente

### PARE e aguarde resposta antes de executar

- Qualquer alteração em autenticação, sessão ou fluxo de login
- Alterar ou criar políticas de acesso ao banco
- Qualquer migration, mesmo simples
- Mudança em isolamento de dados por tenant/organização
- Deletar qualquer arquivo, tabela, coluna ou trigger
- Remover export que pode estar em uso

### EXECUTE sem perguntar

- Criar componente novo em pasta correta
- Corrigir bug visual isolado sem efeito em dados
- Ajustar estilos ou layout
- Criar novo hook de query seguindo padrão existente
- Corrigir erro de tipo sem alterar lógica
- Atualizar `docs/` para refletir mudança implementada

### Conflito entre código e documentação

1. PARE — não escolha um lado por conta própria
2. IDENTIFIQUE com precisão: arquivo + linha do código e arquivo da documentação
3. REPORTE ao usuário antes de qualquer ação
4. AGUARDE resposta

---

## Escopo de Mudanças

Faça apenas o que foi pedido. Não melhore o entorno.

Proibido sem solicitação explícita:

- Refatorar código adjacente ao bug corrigido
- Adicionar validações para cenários que não existem no fluxo real
- Criar utilitários para uso único
- Adicionar comentários em código não alterado
- Adicionar tipagem em código não tocado
- Propor melhorias fora do escopo da tarefa
- Adicionar feature "enquanto está aqui"

---

## Preferências de Sessão

- Respostas em [IDIOMA_UX]
- Respostas diretas e objetivas
- Gerenciador de pacotes: [PKG_MANAGER]
- Editor: VS Code

---

## Conclusão de Tarefa

Ao finalizar trabalho com alterações em arquivos ou sistema, execute `/project:done`.
