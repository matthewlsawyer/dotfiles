#!/bin/bash

# Contract: bootstrap pipeline step 3 — desktop.sh
# XFCE desktop, compositor, themes, and base fonts. See install/README.md.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/sudov.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

pinstall xfce4
pinstall gtk-xfce-engine gtk-engine-murrine gtk-engines
pinstall xdg-user-dirs-gtk

pinstall thunar-archive-plugin
pinstall thunar-shares-plugin
pinstall xfce4-whiskermenu-plugin
pinstall xfce4-pulseaudio-plugin

# Compositor (see MODERNIZATION.md — picom migration)
pinstall compton

# Screen lock
pinstall i3lock

# Themes and icons
pinstall arc-gtk-theme
yinstall elementary-xfce-icons-git

# Base fonts (Nerd Fonts via optional fonts.sh)
pinstall ttf-google-fonts-typewolf \
            adobe-source-code-pro-fonts \
            ttf-droid \
            ttf-fira-code \
            otf-fira-code \
            ttf-fira-mono \
            otf-fira-mono \
            awesome-terminal-fonts
yinstall awesome-terminal-fonts-patched
