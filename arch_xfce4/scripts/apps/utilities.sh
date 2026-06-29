#!/bin/bash

# Optional — general utilities and desktop apps.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

pkg_install htop iotop powertop atop
pkg_install lm_sensors
aur_install update-grub
pkg_install hardinfo
pkg_install viewnior
pkg_install imagemagick
pkg_install scrot
pkg_install lesspipe
pkg_install transmission-qt
pkg_install gparted
pkg_install tilix
pkg_install filezilla
pkg_install gnuplot
pkg_install file-roller
pkg_install bookworm
pkg_install alacarte
pkg_install seahorse
aur_install qdirstat
pkg_install ffmpegthumbnailer
pkg_install hdparm
pkg_install smartmontools
pkg_install unzip p7zip unrar
