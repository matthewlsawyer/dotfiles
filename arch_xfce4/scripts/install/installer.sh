#!/bin/bash

# installer.sh — AUR helper (yaourt). See apply.sh bootstrap_pipeline.

if pacman -Qs yaourt > /dev/null; then
    echo "yaourt already installed"
    exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"

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
