#!/bin/bash

# postinstall.sh — system tuning after sync. GPU → system/graphics-nvidia.sh.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"

# After run_sync (apply.sh tail): refresh fontconfig for desktop.sh pacman fonts + synced dotfiles.
fc-cache -f

install_user="${USER:-$(id -un)}"
sudo usermod -aG input "$install_user"

# lm_sensors / fancontrol — see README post-install manual steps
