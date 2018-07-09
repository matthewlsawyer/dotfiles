#!/bin/bash

# This file will grab XFCE and related packages.

. sudov.sh
. functions.sh

pinstall xfce4
pinstall gtk-xfce-engine gtk-engine-murrine gtk-engines
pinstall xdg-user-dirs-gtk

# Right-click menu for unzipping
pinstall thunar-archive-plugin
pinstall thunar-shares-plugin
pinstall xfce4-whiskermenu-plugin
pinstall xfce4-pulseaudio-plugin

# Compton will be used for compositing
pinstall compton

# i3lock is used to lock the screen
pinstall i3lock

# Panel plugins
# sudo pacman -S --no-confirm --needed xfce4-cpufreq-plugin
# sudo pacman -S --no-confirm --needed xfce4-datetime-plugin

# If home directories are not present:
#  xdg-user-dirs-update

##
## Themes and icons
##

# Arc
pinstall arc-gtk-theme

# Elementary
yinstall elementary-xfce-icons-git
