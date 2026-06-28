#!/bin/bash

# postinstall.sh — system tuning after sync. GPU → hardware/graphics-nvidia.sh.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"

fc-cache -f

sudo systemctl enable paccache.timer
sudo systemctl start paccache.timer

# TODO: new home?
# Kernel 4.18+ native Steam controller support conflicts with Steam — blacklist if needed
sudo modprobe -r hid_steam 2>/dev/null || true
echo 'blacklist hid_steam' | sudo tee /etc/modprobe.d/sc.conf > /dev/null

sudo usermod -aG input "$USER"

# lm_sensors / fancontrol — see README post-install manual steps
