#!/bin/bash

# packages.sh — core formulae from Brewfile.bootstrap.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"

brew bundle install --file="$DOTFILES_PROFILE_ROOT/Brewfile.bootstrap"
brew link python@3.14
