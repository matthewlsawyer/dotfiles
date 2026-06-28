#!/bin/bash

# Internal: sync — dotfiles → $HOME.
#
# Invoked by apply.sh sync and bootstrap.sh (pipeline step).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/init.sh
. "$SCRIPT_DIR/lib/init.sh"

if [[ -d "$DOTFILES_SHARED_ROOT/dotfiles" ]]; then
    rsync -avh --no-perms "$DOTFILES_SHARED_ROOT/dotfiles/" ~/
fi
rsync -avh --no-perms "$DOTFILES_PLATFORM_ROOT/dotfiles/" ~/
