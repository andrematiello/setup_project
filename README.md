# claude-kit

Kit de configuração do ambiente Claude Code para projetos de software.

Instala em qualquer projeto:
- `CLAUDE.md` — especificação comportamental para o agente
- `.claude/commands/` — protocolo operacional (fix, feature, deploy, release, etc.)
- `.claude/settings.json` — permissões base

---

## Instalação

```bash
curl -s https://raw.githubusercontent.com/andrematiello/setup_project/main/setup.sh | bash
```

Ou, se preferir inspecionar antes de executar:

```bash
curl -O https://raw.githubusercontent.com/andrematiello/setup_project/main/setup.sh
bash setup.sh
```

Para forçar sobrescrita de arquivos existentes:

```bash
bash setup.sh --force
```

---

## Primeiro uso

Após a instalação, abra o projeto no Claude Code e execute:

```
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

```
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
└── settings.json

CLAUDE.md  ← gerado pelo /project:setup
```

---

## Personalização

Após o setup inicial, adicione conforme necessário:

- `.claude/rules/` — regras detalhadas por domínio (auth, banco, componentes, etc.)
- `.claude/skills/` — skills adicionais
- `.claude/docs/` — documentação operacional interna

---

## Requisitos

- [Claude Code](https://claude.ai/code) instalado
- `curl` disponível no terminal
- Git inicializado no projeto

---

## Contribuição

Abra uma issue ou pull request em [andrematiello/setup_project](https://github.com/andrematiello/setup_project).
