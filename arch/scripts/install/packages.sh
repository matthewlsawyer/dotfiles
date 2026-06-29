#!/bin/bash

# packages.sh — pacman-only headless base. No AUR helper.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

sudo pacman -Syy


pkg_install vim git tmux jq zsh
pkg_install rsync
pkg_install base-devel
pkg_install curl wget less
