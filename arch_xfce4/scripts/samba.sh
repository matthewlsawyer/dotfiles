#!/bin/bash

# This file is responsible for configuring and setting up samba.

. sudov.sh
. functions.sh

pinstall samba smbclient cifs-utils
pinstall gvfs gvfs-smb

# Get samba configuration
sudo wget -O /etc/samba/smb.conf \
    "https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD"

# Enable the cifs module
sudo modprobe cifs

# sudo mount -t cifs //$server/Public /mnt/path/to/Public -o user=$user,uid=$user,gid=users
