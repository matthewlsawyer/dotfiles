#!/bin/bash

# Contract: sync | bootstrap | help
# Edit bootstrap_pipeline below; tail is always: run_sync → postinstall
#
# Invoked by dotfiles.sh pi_omv sync | bootstrap (or pi-omv host without apply.sh).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/lib/init.sh
. "$SCRIPT_DIR/scripts/lib/init.sh"

bootstrap_pipeline=(
    "$DOTFILES_SCRIPTS_ROOT/bootstrap/setup.sh"
    "$DOTFILES_SCRIPTS_ROOT/bootstrap/omv.sh"
)

apply_usage() {
    cat <<EOF
Usage: $0 sync|bootstrap|help

  sync        Dotfiles → \$HOME (shared layer only; no pi_omv/dotfiles/ yet)
  bootstrap   Full install pipeline (two-phase — see README.md)

Or: dotfiles.sh pi_omv sync | bootstrap

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

Two-phase bootstrap (see README.md):
  1. setup.sh + preinstall → reboot
  2. omv.sh (re-run bootstrap after reboot, or run omv.sh directly)

Manual steps:
  sudo raspi-config
  adduser -m <user>

Recommended optional:
  cd pi_omv/scripts
  ./extras/omv-extras.sh
  SAMBA_USER=... SAMBA_SERVER=... SAMBA_MOUNT=... ./extras/samba.sh

See README.md for optional modules.
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
