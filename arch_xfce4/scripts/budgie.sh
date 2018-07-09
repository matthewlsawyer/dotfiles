#!/bin/bash

# This file will grab Budgie by Solus and related packages.

# TODO move to another folder or put in DE switch

. sudov.sh
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
