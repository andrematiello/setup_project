# Changelog

Todas as mudanças notáveis neste projeto são documentadas aqui.
Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/).

---

## [Não lançado]

## [0.3.0] — 2026-04-08

### Adicionado
- Modo `--update` no `setup.sh`: compara cada template com o arquivo local, atualiza os idênticos, instala os novos e registra os divergentes em `.claude/update-pending.txt`
- Comando `/project:update-kit`: consolida arquivos divergentes arquivo por arquivo, classificando cada diferença em categorias objetivas (ADITIVO, PLACEHOLDER, PROJETO-ESPECÍFICO, MELHORIA, SEGURANÇA, CONFLITO, REMOÇÃO) e aguardando aprovação explícita do usuário a cada decisão
- Skill `security-audit`: auditoria completa de segurança baseada em OWASP, NIST SSDF e Secure by Design — complementar ao `security-check`
- Tabela `security-check` vs `security-audit` no README com critérios de uso de cada uma
- Seção "Atualização" no README documentando o fluxo `--update` + `/project:update-kit`
- `docs/business-domain.md` com decisões de produto do kit

### Alterado

- `templates/commands/start.md`: expandido com 5 fases estruturadas (Onboarding, Security, README, Business, Relatório), checklist diário de segurança integrado e relatório consolidado por sessão
- `templates/CLAUDE.md`: instrução de início automático de sessão — Claude executa `/project:start` na primeira mensagem sem solicitar confirmação
- `setup.sh`: detecção automática de curl com backend schannel (Windows) e aplicação de `--ssl-no-revoke` em todos os downloads internos
- `setup.sh`: aviso ao encontrar `.claude` existente agora menciona `--update` como opção além de `--force`

### Corrigido

- `setup.sh` via `curl | bash`: `read` agora usa `< /dev/tty` para funcionar quando stdin é o pipe
- Downloads internos do `setup.sh` falhavam silenciosamente no Windows por SSL (schannel) — corrigido com detecção automática de `CURL_OPTS`

---

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
