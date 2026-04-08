# claude-kit

Kit de configuração do ambiente Claude Code para projetos de software.

Instala em qualquer projeto:

- `CLAUDE.md` — especificação comportamental para o agente
- `.claude/commands/` — protocolo operacional (fix, feature, deploy, release, etc.)
- `.claude/rules/` — regras por domínio (segurança, banco, componentes, TypeScript, testes, documentação)
- `.claude/skills/` — skills automáticas (code-review, security-check, update-docs, new-migration)
- `.claude/settings.json` — permissões base
- `docs/` — templates de changelog e onboarding

---

## Instalação

```bash
curl -s https://raw.githubusercontent.com/andrematiello/setup_project/main/setup.sh | bash
```

> **Windows (Git Bash):** se o comando não produzir nenhuma saída, use `--ssl-no-revoke`:
>
> ```bash
> curl -s --ssl-no-revoke https://raw.githubusercontent.com/andrematiello/setup_project/main/setup.sh | bash
> ```

Ou, se preferir inspecionar antes de executar:

```bash
curl -O https://raw.githubusercontent.com/andrematiello/setup_project/main/setup.sh
bash setup.sh
```

Para forçar sobrescrita de arquivos existentes (local):

```bash
bash setup.sh --force
```

Via curl (sem prompt de confirmação):

```bash
curl -s https://raw.githubusercontent.com/andrematiello/setup_project/main/setup.sh | bash -s -- --force
```

---

## Atualização

Para atualizar o kit em um projeto já instalado:

```bash
curl -s --ssl-no-revoke https://raw.githubusercontent.com/andrematiello/setup_project/main/setup.sh | bash -s -- --update
```

O script vai:

1. Baixar cada template do repositório
2. Comparar com o arquivo local
3. **Idêntico ao template** (sem customização) → atualiza automaticamente
4. **Novo arquivo** (não existia no projeto) → instala automaticamente
5. **Divergente** (customização local detectada) → registra em `.claude/update-pending.txt`

Ao final, se houver arquivos divergentes, execute no Claude Code:

```text
/project:update-kit
```

O agente consolida arquivo por arquivo, classificando cada diferença como aditivo, melhoria, customização local, conflito ou remoção — e só avança com sua aprovação.

> `CLAUDE.md` nunca é substituído automaticamente, em nenhum modo.

---

## Primeiro uso

Após a instalação, abra o projeto no Claude Code e execute:

```text
/project:setup
```

O agente vai:

1. Ler o contexto do projeto (`package.json`, estrutura de pastas, configs de deploy, etc.)
2. Detectar stack, gerenciador de pacotes e serviços externos
3. Gerar um rascunho de `CLAUDE.md` adaptado ao projeto
4. Apresentar o rascunho para revisão
5. Salvar após sua aprovação

---

## Comandos disponíveis após instalação

| Comando | Quando usar |
| --- | --- |
| `/project:setup` | Uma vez, após instalar o kit |
| `/project:start` | Início de toda sessão de trabalho |
| `/project:feature [descrição]` | Implementar nova funcionalidade |
| `/project:fix [descrição]` | Corrigir um bug |
| `/project:review [arquivo]` | Code review estruturado |
| `/project:refactor [alvo]` | Refatorar sem alterar comportamento |
| `/project:document [modo]` | Gerar ou atualizar documentação |
| `/project:deploy-check` | Gate de qualidade antes de produção |
| `/project:done` | Encerrar sessão com changelog e push |
| `/project:release [versão]` | Publicar release formal |

---

## Estrutura instalada

```text
.claude/
├── commands/
│   ├── setup.md
│   ├── start.md
│   ├── feature.md
│   ├── fix.md
│   ├── review.md
│   ├── refactor.md
│   ├── document.md
│   ├── deploy-check.md
│   ├── done.md
│   └── release.md
├── rules/
│   ├── security.md
│   ├── auth.md
│   ├── database.md
│   ├── typescript.md
│   ├── testing.md
│   ├── components.md
│   ├── code-style.md
│   └── documentation.md
├── skills/
│   ├── code-review/SKILL.md
│   ├── security-check/SKILL.md
│   ├── update-docs/SKILL.md
│   └── new-migration/SKILL.md
└── settings.json

docs/
├── changelog_internal.md   ← log de sessões do agente
└── onboarding_morning.md   ← checklist de retomada

CLAUDE.md  ← gerado pelo /project:setup
```

---

## Personalização

Todos os arquivos instalados são pontos de partida. Itens marcados com `[ADAPTÁVEL]` devem ser ajustados ao projeto. Itens marcados com `[GENÉRICO]` funcionam sem modificação na maioria dos projetos.

---

## Skills de segurança: security-check vs security-audit

| | `security-check` | `security-audit` |
| --- | --- | --- |
| **Quando** | Durante implementação, ao tocar áreas sensíveis | Sob demanda — "quero saber se minha app é segura" |
| **Escopo** | Pontual — auth, banco, APIs, env vars | Amplo — arquitetura inteira, CI/CD, infra, dependências |
| **Output** | Sinais e bloqueios antes de escrever código | Relatório estruturado com riscos, CVSS, OWASP, recomendações |
| **Analogia** | Guarda de segurança na porta | Auditor que vem fazer uma perícia |

São complementares — `security-check` roda o tempo todo silenciosamente; `security-audit` é invocado explicitamente quando você quer uma análise completa.

---

## Requisitos

- [Claude Code](https://claude.ai/code) instalado
- `curl` disponível no terminal
- Git inicializado no projeto

---

## Contribuição

Abra uma issue ou pull request em [andrematiello/setup_project](https://github.com/andrematiello/setup_project).
