#!/bin/bash

# Paths for internal scripts under scripts/. Source from:
#   apply.sh (platform root):   . "$SCRIPT_DIR/scripts/lib/init.sh"
#   scripts/*/*.sh:             . "$SCRIPT_DIR/../lib/init.sh"
#
# DOTFILES_SCRIPTS_ROOT → <platform>/scripts (internal)
# DOTFILES_PLATFORM_ROOT → <platform> (interface + dotfiles)

DOTFILES_SCRIPTS_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOTFILES_PLATFORM_ROOT="$(cd "$DOTFILES_SCRIPTS_ROOT/.." && pwd)"
export DOTFILES_SCRIPTS_ROOT DOTFILES_PLATFORM_ROOT

export HOMEBREW_CASK_OPTS="${HOMEBREW_CASK_OPTS:---appdir=/Applications}"
