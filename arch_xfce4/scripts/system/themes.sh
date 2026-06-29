#!/bin/bash

# Optional — Arc GTK theme (AUR).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

aur_install arc-gtk-theme
