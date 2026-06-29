#!/bin/bash

# desktop.sh — XFCE desktop, compositor, themes, base fonts.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

pkg_install xfce4
pkg_install gtk-xfce-engine gtk-engine-murrine gtk-engines
pkg_install xdg-user-dirs-gtk

pkg_install thunar-archive-plugin
pkg_install thunar-shares-plugin
pkg_install xfce4-whiskermenu-plugin
pkg_install xfce4-pulseaudio-plugin

# Compositor
pkg_install picom

# Screen lock
pkg_install i3lock

# GTK theme → optional system/themes.sh (arc-gtk-theme is AUR)
# Icon theme → optional system/icons.sh

# Base fonts — official repos only (AUR/extras → optional system/fonts.sh)
pkg_install adobe-source-code-pro-fonts \
            ttf-droid \
            ttf-fira-code \
            ttf-fira-mono \
            otf-fira-mono \
            awesome-terminal-fonts
