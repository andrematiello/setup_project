# Changelog

Todas as mudanças notáveis neste projeto são documentadas aqui.
Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/).

---

## [Não lançado]

## [0.2.0] — 2026-04-08

### Adicionado
- Catálogos completos de prompts-semente para regenerar comandos e docs adaptados a qualquer projeto (`templates/docs/commands-prompts.md`, `templates/docs/docs-prompts.md`)
- Regra de documentação (`templates/rules/documentation.md`) — define quando atualizar CHANGELOG.md, business-domain e README

### Corrigido
- Campo `QUEM ACIONA` padronizado no cabeçalho do `templates/commands/done.md`, alinhando com o formato dos demais comandos

---

## [0.1.0] — 2026-04-07

### Adicionado
- Estrutura completa do kit: `setup.sh`, `README.md` e `templates/`
- Template de `CLAUDE.md` com todas as seções obrigatórias e placeholders explícitos
- Comando `/project:setup` com 4 fases: análise automática, entrevista estruturada, geração de CLAUDE.md e aprovação
- Comandos operacionais: `start`, `feature`, `fix`, `review`, `refactor`, `document`, `deploy-check`, `done`, `release`
- Rules por domínio: `security`, `auth`, `database`, `typescript`, `testing`, `components`, `code-style`
- Skills automáticas: `code-review`, `security-check`, `update-docs`, `new-migration`
- Templates de docs: `changelog_internal.md`, `onboarding_morning.md`
- Detecção automática de gerenciador de pacotes (bun / pnpm / yarn / npm) no `setup.sh`

---

[Não lançado]: https://github.com/andrematiello/setup_project/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/andrematiello/setup_project/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/andrematiello/setup_project/releases/tag/v0.1.0
