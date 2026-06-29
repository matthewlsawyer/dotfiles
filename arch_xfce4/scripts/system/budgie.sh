#!/bin/bash

# Optional — Budgie desktop environment and related packages.

# TODO move to another folder or put in DE switch

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

pkg_install budgie-desktop \
            gnome \
            gnome-backgrounds \
            gnome-control-center \
            gnome-screensaver

aur_install budgie-extras \
            budgie-caffeine-applet \
            budgie-calendar-applet \
            budgie-haste-applet \
            budgie-pixel-saver-applet \
            budgie-advanced-brightness-controller-applet
