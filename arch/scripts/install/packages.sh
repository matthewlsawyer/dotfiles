#!/bin/bash

# Contract: bootstrap pipeline step 1 — packages.sh
# Pacman-only headless base. No AUR helper.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"

sudo pacman -Syy

. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

pinstall vim git tmux jq zsh
pinstall rsync
pinstall base-devel
pinstall curl wget less
