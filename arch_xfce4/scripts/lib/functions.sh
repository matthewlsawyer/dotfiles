#!/bin/bash

# Global functions — sourced by optional module scripts.

# shellcheck source=../../../shared/scripts/lib/pacman.sh
. "$DOTFILES_SHARED_ROOT/scripts/lib/pacman.sh"

function yinstall() {
    yaourt -S --noconfirm --needed "$@"
}
