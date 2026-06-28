#!/bin/bash

# This file installs and sets up flatpak.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

pinstall flatpak

# Add public flathub repository
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
