#!/bin/bash

# Host apply — explicitly overrides arch_xfce4/apply.sh (does not delegate).
# dotfiles.sh prefers this file when targeting arch-desktop.
# Profile scripts via DOTFILES_SCRIPTS_ROOT; host adds third dotfiles layer in run_sync.
#
# Contract: sync | bootstrap | help
# Edit bootstrap_pipeline below; tail is always: run_sync → postinstall
#
# Invoked by: dotfiles.sh arch-desktop sync | bootstrap

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/lib/init.sh
. "$SCRIPT_DIR/scripts/lib/init.sh"

bootstrap_pipeline=(
    "$DOTFILES_SCRIPTS_ROOT/bootstrap/installer.sh"
    "$DOTFILES_SCRIPTS_ROOT/bootstrap/packages.sh"
    "$DOTFILES_SCRIPTS_ROOT/bootstrap/desktop.sh"
)

apply_usage() {
    cat <<EOF
Usage: $0 sync|bootstrap|help

  sync        Dotfiles → \$HOME (shared → profile → host)
  bootstrap   Full install pipeline

Or: dotfiles.sh arch-desktop sync | bootstrap

See hosts/arch-desktop/README.md.
EOF
}

run_sync() {
    [[ -d "$DOTFILES_SHARED_ROOT/dotfiles" ]] && \
        rsync -avh --no-perms --exclude='.local/bin/' "$DOTFILES_SHARED_ROOT/dotfiles/" ~/
    [[ -d "$DOTFILES_PROFILE_ROOT/dotfiles" ]] && \
        rsync -avh --no-perms --exclude='.local/bin/' "$DOTFILES_PROFILE_ROOT/dotfiles/" ~/
    [[ -d "$DOTFILES_HOST_ROOT/dotfiles" ]] && \
        rsync -avh --no-perms --exclude='.local/bin/' "$DOTFILES_HOST_ROOT/dotfiles/" ~/
    mkdir -p ~/.local/bin
    [[ -d "$DOTFILES_SHARED_ROOT/dotfiles/.local/bin" ]] && \
        rsync -avh "$DOTFILES_SHARED_ROOT/dotfiles/.local/bin/" ~/.local/bin/
    [[ -d "$DOTFILES_PROFILE_ROOT/dotfiles/.local/bin" ]] && \
        rsync -avh "$DOTFILES_PROFILE_ROOT/dotfiles/.local/bin/" ~/.local/bin/
    [[ -d "$DOTFILES_HOST_ROOT/dotfiles/.local/bin" ]] && \
        rsync -avh "$DOTFILES_HOST_ROOT/dotfiles/.local/bin/" ~/.local/bin/
}

run_bootstrap() {
    for step in "${bootstrap_pipeline[@]}"; do
        echo "==> $(basename "$step")"
        "$step"
    done
    run_sync
    echo "==> postinstall.sh"
    "$DOTFILES_SCRIPTS_ROOT/bootstrap/postinstall.sh"
    echo "==> bootstrap complete"
    cat <<EOF

Recommended optional:
  cd arch_xfce4/scripts
  ./system/graphics-nvidia.sh
  ./apps/dev.sh && ./apps/utilities.sh
  ../../shared/scripts/extras/keys.sh

Host system files (manual):
  sudo cp hosts/arch-desktop/files/etc/systemd/network/51-static.network /etc/systemd/network/
  sudo cp hosts/arch-desktop/files/etc/X11/xorg.conf.d/20-intel.conf /etc/X11/xorg.conf.d/

See hosts/arch-desktop/README.md and arch_xfce4/README.md.
EOF
}

case "${1:-}" in
    sync)
        run_sync
        ;;
    bootstrap)
        run_bootstrap
        ;;
    help|--help|-h)
        apply_usage
        ;;
    "")
        echo "Missing command. Use: sync | bootstrap" >&2
        apply_usage >&2
        exit 1
        ;;
    *)
        echo "Unknown command: $1" >&2
        apply_usage >&2
        exit 1
        ;;
esac
