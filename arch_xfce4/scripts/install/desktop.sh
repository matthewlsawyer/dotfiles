#!/bin/bash

# desktop.sh — XFCE desktop, compositor, themes, base fonts.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

pkg_install xfce4
pkg_install gtk-xfce-engine gtk-engine-murrine gtk-engines
pkg_install xdg-user-dirs-gtk

pkg_install thunar-archive-plugin
pkg_install thunar-shares-plugin
pkg_install xfce4-whiskermenu-plugin
pkg_install xfce4-pulseaudio-plugin

# Compositor (see MODERNIZATION.md — picom migration)
pkg_install compton

# Screen lock
pkg_install i3lock

# Themes and icons
pkg_install arc-gtk-theme
yinstall elementary-xfce-icons-git

# Base fonts (Nerd Fonts via optional fonts.sh)
pkg_install ttf-google-fonts-typewolf \
            adobe-source-code-pro-fonts \
            ttf-droid \
            ttf-fira-code \
            otf-fira-code \
            ttf-fira-mono \
            otf-fira-mono \
            awesome-terminal-fonts
yinstall awesome-terminal-fonts-patched
