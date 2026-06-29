#!/bin/bash

# Optional — pacman cache: enable periodic cleanup timer + one-shot trim.
# Requires pacman-contrib (bootstrap/packages.sh). Needs systemd (skip start in Docker).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"

sudo systemctl enable paccache.timer
if ! sudo systemctl start paccache.timer 2>/dev/null; then
    echo "paccache.timer: enabled but not started (systemd not running?)"
fi

# Remove unused packages
# WARNING: Make sure you want to do this
# sudo pacman -Rns $(pacman -Qtdq)

# Remove cache of all but latest version of package and all cache from uninstalled packages
sudo paccache -rk1 -ruk0
