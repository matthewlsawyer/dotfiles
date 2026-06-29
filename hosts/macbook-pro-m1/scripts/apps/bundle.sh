#!/bin/bash

# Optional — apps and casks from host Brewfile.apps.
# Host-only — machine-specific; not part of macos profile.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"

brew bundle install --file="$DOTFILES_HOST_ROOT/Brewfile.apps"
