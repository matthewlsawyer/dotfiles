#!/bin/bash

# This file will grab Budgie by Solus and related packages.

# TODO move to another folder or put in DE switch

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

pinstall budgie-desktop \
            gnome \
            gnome-backgrounds \
            gnome-control-center \
            gnome-screensaver

yinstall budgie-extras \
            budgie-caffeine-applet \
            budgie-calendar-applet \
            budgie-haste-applet \
            budgie-pixel-saver-applet \
            budgie-advanced-brightness-controller-applet
