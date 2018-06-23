#!/bin/bash

# This file will grab Budgie by Solus and related packages.

# TODO move to another folder or put in DE switch

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

. functions.sh

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
