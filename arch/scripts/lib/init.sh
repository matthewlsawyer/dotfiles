#!/bin/bash

# Paths for internal scripts under scripts/. Source from:
#   apply.sh (platform root):   . "$SCRIPT_DIR/scripts/lib/init.sh"
#   scripts/*/*.sh:         . "$SCRIPT_DIR/../lib/init.sh"
#
# DOTFILES_SCRIPTS_ROOT → arch/scripts (internal)
# DOTFILES_PLATFORM_ROOT → arch (interface + dotfiles)

DOTFILES_SCRIPTS_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOTFILES_PLATFORM_ROOT="$(cd "$DOTFILES_SCRIPTS_ROOT/.." && pwd)"
DOTFILES_REPO_ROOT="$(cd "$DOTFILES_PLATFORM_ROOT/.." && pwd)"
DOTFILES_SHARED_ROOT="$DOTFILES_REPO_ROOT/shared"
export DOTFILES_SCRIPTS_ROOT DOTFILES_PLATFORM_ROOT DOTFILES_REPO_ROOT DOTFILES_SHARED_ROOT
