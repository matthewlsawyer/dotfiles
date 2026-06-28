#!/bin/bash

# Host path roots. Source from hosts/<name>/apply.sh only — never with profile init.
#
# DOTFILES_HOST_ROOT    → hosts/<name>
# DOTFILES_PROFILE_ROOT → from hosts/<name>/profile manifest
# DOTFILES_SCRIPTS_ROOT → <profile>/scripts

DOTFILES_HOST_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOTFILES_REPO_ROOT="$(cd "$DOTFILES_HOST_ROOT/../.." && pwd)"
DOTFILES_SHARED_ROOT="$DOTFILES_REPO_ROOT/shared"
DOTFILES_PROFILE_ROOT="$DOTFILES_REPO_ROOT/$(tr -d '[:space:]' < "$DOTFILES_HOST_ROOT/profile")"
DOTFILES_SCRIPTS_ROOT="$DOTFILES_PROFILE_ROOT/scripts"
export DOTFILES_HOST_ROOT DOTFILES_REPO_ROOT DOTFILES_SHARED_ROOT \
       DOTFILES_PROFILE_ROOT DOTFILES_SCRIPTS_ROOT
