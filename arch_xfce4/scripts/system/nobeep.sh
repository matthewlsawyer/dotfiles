#!/bin/bash

# Optional — blacklist the internal PC speaker (pcspkr). Run after bootstrap if wanted.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"

if [[ "$(modinfo pcspkr 2>&1)" == *"not found"* ]]; then
    echo "pcspkr module not present — nothing to do."
    exit 0
fi

sudo rmmod pcspkr 2>/dev/null || true
echo 'blacklist pcspkr' | sudo tee /etc/modprobe.d/nobeep.conf > /dev/null
echo "Blacklisted pcspkr in /etc/modprobe.d/nobeep.conf"
