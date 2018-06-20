#!/bin/bash

# This file will grab XFCE and related packages.

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo pacman -S --noconfirm --needed -q xfce4

# Right-click menu for unzipping
sudo pacman -S --noconfirm --needed -q thunar-archive-plugin
sudo pacman -S --noconfirm --needed -q thunar-shares-plugin

# Compton will be used for compositing
sudo pacman -S --noconfirm --needed -q compton

# i3lock is used to lock the screen
sudo pacman -S --noconfirm --needed -q i3lock

# Panel plugins
# sudo pacman -S --no-confirm --needed xfce4-cpufreq-plugin
# sudo pacman -S --no-confirm --needed xfce4-datetime-plugin
