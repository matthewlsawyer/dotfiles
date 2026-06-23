#!/bin/bash

# Contract: bootstrap pipeline step 1 — installer.sh
# Install AUR helper (yaourt) if not present. See install/README.md.

if pacman -Qs yaourt > /dev/null; then
    echo "yaourt already installed"
    exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/sudov.sh"

sudo pacman -Sy --noconfirm --needed -q yajl

cd "$HOME" \
    && git clone https://aur.archlinux.org/package-query.git \
    && cd "$HOME/package-query" \
    && makepkg -s
sudo pacman -U --noconfirm --needed "$HOME"/package-query/package-query-*-x86_64.pkg.tar.xz

cd "$HOME" \
    && git clone https://aur.archlinux.org/yaourt.git \
    && cd "$HOME/yaourt" \
    && makepkg -s
sudo pacman -U --noconfirm --needed "$HOME"/yaourt/yaourt-*-any.pkg.tar.xz

rm -fr "$HOME/package-query" "$HOME/yaourt"
