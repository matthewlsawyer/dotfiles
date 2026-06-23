#!/bin/bash

# Contract: sync — apply path; bootstrap pipeline step 3 — sync.sh
#
# Apply:     invoked by apply.sh (default)
# Bootstrap: step 3 of installer → packages → sync → postinstall
# See install/README.md.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/init.sh
. "$SCRIPT_DIR/lib/init.sh"

if [[ ! -d "$DOTFILES_PLATFORM_ROOT/dotfiles" ]]; then
    echo "No dotfiles/ for macOS yet — nothing to sync."
    echo "Run: ./apply.sh bootstrap  (or: dotfiles.sh macos bootstrap)"
    exit 0
fi

rsync -avh --no-perms "$DOTFILES_PLATFORM_ROOT/dotfiles/" ~/
