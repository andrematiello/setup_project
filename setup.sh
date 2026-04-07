#!/usr/bin/env bash
# claude-kit — instalador
# Uso: curl -s https://raw.githubusercontent.com/andrematiello/setup_project/main/setup.sh | bash
# Ou:  bash setup.sh [--force]

set -euo pipefail

REPO="https://raw.githubusercontent.com/andrematiello/setup_project/main"
FORCE=false

for arg in "$@"; do
  case $arg in
    --force) FORCE=true ;;
  esac
done

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

echo ""
echo -e "${BOLD}claude-kit — configuração do ambiente Claude Code${NC}"
echo "=================================================="
echo ""

# Verificar se .claude já existe
if [ -d ".claude" ] && [ "$FORCE" = false ]; then
  echo -e "${YELLOW}⚠  A pasta .claude já existe neste projeto.${NC}"
  echo "   Use --force para sobrescrever arquivos existentes."
  echo ""
  read -rp "   Continuar mesmo assim? (s/N) " confirm
  if [[ ! "$confirm" =~ ^[sS]$ ]]; then
    echo "   Instalação cancelada."
    exit 0
  fi
  echo ""
fi

# Detectar gerenciador de pacotes
PKG_MANAGER="npm"
PKG_RUN="npm run"
PKG_EXEC="npx"
if [ -f "bun.lockb" ] || [ -f "bunfig.toml" ]; then
  PKG_MANAGER="bun"
  PKG_RUN="bun run"
  PKG_EXEC="bunx"
elif [ -f "pnpm-lock.yaml" ]; then
  PKG_MANAGER="pnpm"
  PKG_RUN="pnpm run"
  PKG_EXEC="pnpx"
elif [ -f "yarn.lock" ]; then
  PKG_MANAGER="yarn"
  PKG_RUN="yarn"
  PKG_EXEC="yarn dlx"
fi

echo -e "   Gerenciador de pacotes: ${GREEN}${PKG_MANAGER}${NC}"
echo ""

# Criar estrutura de pastas
echo "   Criando estrutura de pastas..."
mkdir -p .claude/commands
mkdir -p .claude/rules
mkdir -p .claude/skills
mkdir -p .claude/docs
echo -e "   ${GREEN}✓${NC} .claude/ estrutura criada"
echo ""

# Função de download
download() {
  local remote_path="$1"
  local local_path="$2"

  if [ -f "$local_path" ] && [ "$FORCE" = false ]; then
    echo -e "   ${YELLOW}→ já existe, pulando:${NC} $local_path"
    return
  fi

  if curl -sf "$REPO/$remote_path" -o "$local_path" 2>/dev/null; then
    echo -e "   ${GREEN}✓${NC} $local_path"
  else
    echo -e "   ${RED}✗ falhou ao baixar:${NC} $local_path"
  fi
}

# Baixar comandos
echo "   Baixando comandos..."
COMMANDS="setup.md done.md deploy-check.md feature.md fix.md review.md refactor.md document.md release.md start.md"
for cmd in $COMMANDS; do
  download "templates/commands/$cmd" ".claude/commands/$cmd"
done
echo ""

# Baixar rules
echo "   Baixando rules..."
mkdir -p .claude/rules
RULES="security.md auth.md database.md typescript.md testing.md components.md code-style.md"
for rule in $RULES; do
  download "templates/rules/$rule" ".claude/rules/$rule"
done
echo ""

# Baixar skills
echo "   Baixando skills..."
SKILLS="code-review security-check update-docs new-migration"
for skill in $SKILLS; do
  mkdir -p ".claude/skills/$skill"
  download "templates/skills/$skill/SKILL.md" ".claude/skills/$skill/SKILL.md"
done
echo ""

# Baixar docs templates
echo "   Baixando templates de documentação..."
mkdir -p docs
download "templates/docs/changelog_internal.md" "docs/changelog_internal.md"
download "templates/docs/onboarding_morning.md" "docs/onboarding_morning.md"
echo ""

# Baixar settings.json
echo "   Baixando configurações..."
download "templates/settings.json" ".claude/settings.json"
echo ""

# CLAUDE.md — só cria se não existir
if [ ! -f "CLAUDE.md" ]; then
  download "templates/CLAUDE.md" "CLAUDE.md"
  echo ""
  echo -e "   ${YELLOW}CLAUDE.md criado a partir do template base.${NC}"
  echo "   Recomendado: rode /project:setup para gerar uma versão adaptada."
else
  echo -e "   ${YELLOW}CLAUDE.md já existe — não foi substituído.${NC}"
fi

echo ""
echo "=================================================="
echo -e "${GREEN}${BOLD}✓ claude-kit instalado com sucesso!${NC}"
echo ""
echo "   Próximo passo: abra este projeto no Claude Code e execute:"
echo ""
echo -e "     ${BOLD}/project:setup${NC}"
echo ""
echo "   O agente vai analisar o projeto e gerar um CLAUDE.md"
echo "   adaptado, que você revisa antes de salvar."
echo ""
