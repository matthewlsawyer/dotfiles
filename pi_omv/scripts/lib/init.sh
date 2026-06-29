#!/bin/bash

# Paths for internal scripts under scripts/. Source from:
#   apply.sh (profile root):    . "$SCRIPT_DIR/scripts/lib/init.sh"
#   scripts/*/*.sh:             . "$SCRIPT_DIR/../lib/init.sh"
#
# DOTFILES_SCRIPTS_ROOT → <profile>/scripts (internal)
# DOTFILES_PROFILE_ROOT → <profile> (interface + dotfiles)

DOTFILES_SCRIPTS_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOTFILES_PROFILE_ROOT="$(cd "$DOTFILES_SCRIPTS_ROOT/.." && pwd)"
DOTFILES_REPO_ROOT="$(cd "$DOTFILES_PROFILE_ROOT/.." && pwd)"
DOTFILES_SHARED_ROOT="$DOTFILES_REPO_ROOT/shared"
export DOTFILES_SCRIPTS_ROOT DOTFILES_PROFILE_ROOT DOTFILES_REPO_ROOT DOTFILES_SHARED_ROOT

export PATH="$DOTFILES_PROFILE_ROOT/dotfiles/.local/bin:$DOTFILES_SHARED_ROOT/dotfiles/.local/bin:$PATH"
