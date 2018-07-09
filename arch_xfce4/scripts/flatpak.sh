#!/bin/bash

# This file installs and sets up flatpak.

. functions.sh

pinstall flatpak

# Add public flathub repository
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
