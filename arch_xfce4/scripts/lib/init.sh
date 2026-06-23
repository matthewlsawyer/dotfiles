#!/bin/bash

# Paths for any script under scripts/. Source from:
#   scripts/*.sh           →  . "$SCRIPT_DIR/lib/init.sh"
#   scripts/*/*.sh         →  . "$SCRIPT_DIR/../lib/init.sh"

DOTFILES_SCRIPTS_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOTFILES_PLATFORM_ROOT="$(cd "$DOTFILES_SCRIPTS_ROOT/.." && pwd)"
export DOTFILES_SCRIPTS_ROOT DOTFILES_PLATFORM_ROOT
