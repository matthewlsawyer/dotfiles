#!/bin/bash

# Contract: sync | bootstrap | help
# Edit bootstrap_pipeline below; tail is always: run_sync → postinstall
#
# Invoked by dotfiles.sh arch_xfce4 sync | bootstrap.

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

  sync        Dotfiles → \$HOME
  bootstrap   Full install pipeline

Or: dotfiles.sh arch_xfce4 sync | bootstrap

See README.md.
EOF
}

run_sync() {
    if [[ -d "$DOTFILES_SHARED_ROOT/dotfiles" ]]; then
        rsync -avh --no-perms --exclude='.local/bin/' "$DOTFILES_SHARED_ROOT/dotfiles/" ~/
    fi
    if [[ -d "$DOTFILES_PROFILE_ROOT/dotfiles" ]]; then
        rsync -avh --no-perms --exclude='.local/bin/' "$DOTFILES_PROFILE_ROOT/dotfiles/" ~/
    fi
    mkdir -p ~/.local/bin
    if [[ -d "$DOTFILES_SHARED_ROOT/dotfiles/.local/bin" ]]; then
        rsync -avh "$DOTFILES_SHARED_ROOT/dotfiles/.local/bin/" ~/.local/bin/
    fi
    if [[ -d "$DOTFILES_PROFILE_ROOT/dotfiles/.local/bin" ]]; then
        rsync -avh "$DOTFILES_PROFILE_ROOT/dotfiles/.local/bin/" ~/.local/bin/
    fi
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

Recommended optional (NVIDIA + dev tooling):
  cd arch_xfce4/scripts
  ./system/firewall.sh
  ./system/graphics-nvidia.sh
  ./apps/dev.sh && ./apps/utilities.sh
  ../../shared/scripts/extras/keys.sh

See README.md for the full module list.
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
