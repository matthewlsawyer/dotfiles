#!/bin/bash

# Optional — elementary-xfce icon theme (AUR). Slow build; noisy in Docker.
# XFCE default icons suffice for bootstrap. Alternative: pkg_install papirus-icon-theme.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

aur_install elementary-xfce-icons-git

for theme in elementary-xfce elementary-xfce-dark elementary-xfce-hidpi; do
    if [[ -d "/usr/share/icons/$theme" ]]; then
        sudo gtk-update-icon-cache -f -t "/usr/share/icons/$theme" 2>/dev/null || true
    fi
done
