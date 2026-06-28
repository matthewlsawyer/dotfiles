#!/bin/bash

# Optional — general utilities and desktop apps.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

pinstall htop iotop powertop atop
pinstall lm_sensors
yinstall update-grub
pinstall hardinfo
pinstall viewnior
pinstall imagemagick
pinstall scrot
pinstall lesspipe
pinstall transmission-qt
pinstall gparted
pinstall tilix
pinstall filezilla
pinstall gnuplot
pinstall file-roller
pinstall bookworm
pinstall alacarte
pinstall seahorse
yinstall qdirstat
pinstall ffmpegthumbnailer
pinstall hdparm
pinstall smartmontools
pinstall unzip p7zip unrar
