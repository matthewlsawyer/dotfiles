#!/bin/bash

# Internal: sync — dotfiles → $HOME.
#
# Invoked by apply.sh sync and bootstrap.sh (pipeline step).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/init.sh
. "$SCRIPT_DIR/lib/init.sh"

rsync -avh --no-perms "$DOTFILES_PLATFORM_ROOT/dotfiles/" ~/
