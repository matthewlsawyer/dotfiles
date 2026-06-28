#!/bin/bash

# pkg_install + yinstall — sourced by install pipeline + optional modules.

# shellcheck source=pacman.sh
. "$DOTFILES_SCRIPTS_ROOT/lib/pacman.sh"
# shellcheck source=yinstall.sh
. "$DOTFILES_SCRIPTS_ROOT/lib/yinstall.sh"
