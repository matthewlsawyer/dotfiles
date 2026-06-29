#!/bin/bash

# Optional — Samba user and CIFS mount (set user, server, mount path before running).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"

: "${SAMBA_USER:?Set SAMBA_USER (local Unix user for Samba)}"
: "${SAMBA_SERVER:?Set SAMBA_SERVER (CIFS server hostname)}"
: "${SAMBA_MOUNT:?Set SAMBA_MOUNT (local mount path, e.g. /mnt/path/to/Public)}"

sudo smbpasswd -a "$SAMBA_USER"
sudo mkdir -p "$SAMBA_MOUNT"
sudo mount -t cifs "//${SAMBA_SERVER}/Public" "$SAMBA_MOUNT" \
    -o "user=${SAMBA_USER},uid=${SAMBA_USER},gid=users"
