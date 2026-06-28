#!/bin/bash

# This file is responsible for configuring and setting up samba.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

pkg_install samba smbclient cifs-utils
pkg_install gvfs gvfs-smb

# Get samba configuration
sudo wget -O /etc/samba/smb.conf \
    "https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD"

# Enable the cifs module
sudo modprobe cifs

# sudo mount -t cifs //$server/Public /mnt/path/to/Public -o user=$user,uid=$user,gid=users
