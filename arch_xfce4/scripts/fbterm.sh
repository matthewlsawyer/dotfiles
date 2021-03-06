#!/bin/bash

# This file installs and sets up fbterm.

. sudov.sh

cat << EOF
You are about to install fbterm, which has a conflict with the ncurses package.
To fix this, you should modify PKGBUILD to remove conflicting line:
  install -Dm644 terminfo/fbterm "${pkgdir}/usr/share/terminfo/f/fbterm"
EOF
# Do not use --noconfirm so we get prompted to edit the PKGBUILD
sudo yaourt -S fbterm-git

# To run fbterm as a non-root user
sudo gpasswd -a $USER video
# To enable keyboard shortcuts for non-root users
sudo setcap 'cap_sys_tty_config+ep' /usr/bin/fbterm
