#!/usr/bin/env bash
# claude-kit — instalador
# Uso: curl -s https://raw.githubusercontent.com/andrematiello/setup_project/main/setup.sh | bash
# Ou:  bash setup.sh [--force] [--update]

set -euo pipefail

REPO="https://raw.githubusercontent.com/andrematiello/setup_project/main"
FORCE=false
UPDATE=false

for arg in "$@"; do
  case $arg in
    --force)  FORCE=true  ;;
    --update) UPDATE=true ;;
  esac
done

if [ "$FORCE" = true ] && [ "$UPDATE" = true ]; then
  echo "Erro: --force e --update são mutuamente exclusivos."
  exit 1
fi

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

# Detectar se curl usa schannel (Windows) e precisa de --ssl-no-revoke
CURL_OPTS=""
if curl --version 2>&1 | grep -qi "schannel"; then
  CURL_OPTS="--ssl-no-revoke"
fi

# Detectar gerenciador de pacotes
PKG_MANAGER="npm"
if [ -f "bun.lockb" ] || [ -f "bunfig.toml" ]; then
  PKG_MANAGER="bun"
elif [ -f "pnpm-lock.yaml" ]; then
  PKG_MANAGER="pnpm"
elif [ -f "yarn.lock" ]; then
  PKG_MANAGER="yarn"
fi

# Listas de arquivos
COMMANDS="setup.md done.md deploy-check.md feature.md fix.md review.md refactor.md document.md release.md start.md update-kit.md"
RULES="security.md auth.md database.md typescript.md testing.md components.md code-style.md documentation.md"
SKILLS="code-review security-check update-docs new-migration security-audit"

# ─── FUNÇÕES ────────────────────────────────────────────────────────────────

download() {
  local remote_path="$1"
  local local_path="$2"

  if [ -f "$local_path" ] && [ "$FORCE" = false ]; then
    echo -e "   ${YELLOW}→ já existe, pulando:${NC} $local_path"
    return
  fi

  if curl -sf $CURL_OPTS "$REPO/$remote_path" -o "$local_path" 2>/dev/null; then
    echo -e "   ${GREEN}✓${NC} $local_path"
  else
    echo -e "   ${RED}✗ falhou ao baixar:${NC} $local_path"
  fi
}

update_file() {
  local remote_path="$1"
  local local_path="$2"
  local tmp_path
  tmp_path=$(mktemp)

  if ! curl -sf $CURL_OPTS "$REPO/$remote_path" -o "$tmp_path" 2>/dev/null; then
    echo -e "   ${RED}✗ falhou ao baixar:${NC} $remote_path"
    rm -f "$tmp_path"
    return
  fi

  if [ ! -f "$local_path" ]; then
    mkdir -p "$(dirname "$local_path")"
    cp "$tmp_path" "$local_path"
    echo -e "   ${GREEN}+${NC} novo: $local_path"
    NEW=$((NEW + 1))
  elif diff -q "$tmp_path" "$local_path" > /dev/null 2>&1; then
    cp "$tmp_path" "$local_path"
    echo -e "   ${GREEN}✓${NC} atualizado: $local_path"
    UPDATED=$((UPDATED + 1))
  else
    echo -e "   ${YELLOW}⚠${NC} divergente (merge necessário): $local_path"
    echo "$local_path|$remote_path" >> ".claude/update-pending.txt"
    PENDING=$((PENDING + 1))
  fi

  rm -f "$tmp_path"
}

# ─── MODO UPDATE ─────────────────────────────────────────────────────────────

if [ "$UPDATE" = true ]; then

  if [ ! -d ".claude" ]; then
    echo -e "${RED}✗ Pasta .claude não encontrada.${NC}"
    echo "   Execute sem --update para fazer a instalação inicial."
    echo ""
    exit 1
  fi

  echo -e "   Gerenciador de pacotes: ${GREEN}${PKG_MANAGER}${NC}"
  echo ""
  echo "   Verificando atualizações..."
  echo ""

  > ".claude/update-pending.txt"
  UPDATED=0
  NEW=0
  PENDING=0

  echo "   Comandos..."
  for cmd in $COMMANDS; do
    update_file "templates/commands/$cmd" ".claude/commands/$cmd"
  done
  echo ""

  echo "   Rules..."
  for rule in $RULES; do
    update_file "templates/rules/$rule" ".claude/rules/$rule"
  done
  echo ""

  echo "   Skills..."
  for skill in $SKILLS; do
    mkdir -p ".claude/skills/$skill"
    update_file "templates/skills/$skill/SKILL.md" ".claude/skills/$skill/SKILL.md"
  done
  echo ""

  echo "   Docs..."
  mkdir -p docs
  update_file "templates/docs/changelog_internal.md" "docs/changelog_internal.md"
  update_file "templates/docs/onboarding_morning.md" "docs/onboarding_morning.md"
  echo ""

  echo "   Settings..."
  update_file "templates/settings.json" ".claude/settings.json"
  echo ""

  echo "=================================================="
  echo -e "${GREEN}${BOLD}Verificação concluída${NC}"
  echo ""
  echo -e "   ${GREEN}✓${NC} Atualizados (sem customização local): ${UPDATED}"
  echo -e "   ${GREEN}+${NC} Novos arquivos instalados:            ${NEW}"

  if [ "$PENDING" -gt 0 ]; then
    echo -e "   ${YELLOW}⚠${NC} Divergentes (merge necessário):       ${PENDING}"
    echo ""
    echo "   Arquivos pendentes registrados em: .claude/update-pending.txt"
    echo ""
    echo "   Próximo passo: abra o Claude Code e execute:"
    echo ""
    echo -e "     ${BOLD}/project:update-kit${NC}"
    echo ""
    echo "   O agente vai consolidar cada arquivo, decisão por decisão,"
    echo "   preservando suas customizações e adotando melhorias do kit."
  else
    echo ""
    echo -e "   ${GREEN}Tudo atualizado. Nenhum merge necessário.${NC}"
    rm -f ".claude/update-pending.txt"
  fi

  echo ""
  exit 0
fi

# ─── MODO INSTALL ────────────────────────────────────────────────────────────

if [ -d ".claude" ] && [ "$FORCE" = false ]; then
  echo -e "${YELLOW}⚠  A pasta .claude já existe neste projeto.${NC}"
  echo "   Use --force para sobrescrever ou --update para atualizar com merge."
  echo ""
  read -rp "   Continuar mesmo assim? (s/N) " confirm < /dev/tty
  if [[ ! "$confirm" =~ ^[sS]$ ]]; then
    echo "   Instalação cancelada."
    exit 0
  fi
  echo ""
fi

echo -e "   Gerenciador de pacotes: ${GREEN}${PKG_MANAGER}${NC}"
echo ""

echo "   Criando estrutura de pastas..."
mkdir -p .claude/commands .claude/rules .claude/skills .claude/docs
echo -e "   ${GREEN}✓${NC} .claude/ estrutura criada"
echo ""

echo "   Baixando comandos..."
for cmd in $COMMANDS; do
  download "templates/commands/$cmd" ".claude/commands/$cmd"
done
echo ""

echo "   Baixando rules..."
for rule in $RULES; do
  download "templates/rules/$rule" ".claude/rules/$rule"
done
echo ""

echo "   Baixando skills..."
for skill in $SKILLS; do
  mkdir -p ".claude/skills/$skill"
  download "templates/skills/$skill/SKILL.md" ".claude/skills/$skill/SKILL.md"
done
echo ""

echo "   Baixando templates de documentação..."
mkdir -p docs
download "templates/docs/changelog_internal.md" "docs/changelog_internal.md"
download "templates/docs/onboarding_morning.md" "docs/onboarding_morning.md"
echo ""

echo "   Baixando configurações..."
download "templates/settings.json" ".claude/settings.json"
echo ""

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
