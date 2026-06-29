#!/bin/bash

# Optional — NVIDIA proprietary driver and post-install tuning.
# Run after bootstrap on discrete NVIDIA hardware only.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

pkg_install nvidia nvidia-utils lib32-nvidia-utils nvidia-settings
pkg_install nvidia-libgl lib32-nvidia-libgl

sudo nvidia-xconfig

# Regenerate initramfs for all installed kernels (see Arch wiki: NVIDIA)
sudo mkinitcpio -P

sudo mkdir -p /etc/pacman.d/hooks
sudo ln -s -t /etc/pacman.d/hooks "$HOME/.local/etc/pacman.d/hooks/nvidia.hook"

echo "NVIDIA driver installed. Reboot if this is a fresh driver install."
