#!/bin/bash

# Optional — niche firmware for specific storage controllers / drives.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

aur_install aic94xx-firmware   # SATA port chip
aur_install wd719x-firmware    # WD HDDs
