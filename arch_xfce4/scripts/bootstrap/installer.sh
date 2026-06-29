#!/bin/bash

# installer.sh — AUR helper (paru). See apply.sh bootstrap_pipeline.

if command -v paru >/dev/null 2>&1 || pacman -Qs paru > /dev/null 2>&1; then
    echo "paru already installed"
    exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"

# Inline pacman -Sy (not pkg_install): first bootstrap step needs DB sync; pkg_install is -S only.
sudo pacman -Sy --noconfirm --needed -q base-devel git rust

cd "$HOME" \
    && git clone https://aur.archlinux.org/paru.git \
    && cd "$HOME/paru" \
    && makepkg -s
sudo pacman -U --noconfirm --needed "$HOME"/paru/paru-*-*.pkg.tar.*

rm -fr "$HOME/paru"
