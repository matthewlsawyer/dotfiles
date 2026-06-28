#!/bin/bash

# Root router — profiles or hosts → apply.sh (sync | bootstrap).
#
# Usage:
#   ./dotfiles.sh arch sync
#   ./dotfiles.sh arch-desktop bootstrap
#   DOTFILES_TARGET=arch-desktop ./dotfiles.sh sync

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

platform_dir() {
    case "$1" in
        arch) echo arch ;;
        arch_xfce4) echo arch_xfce4 ;;
        macos) echo macos ;;
        crostini) echo crostini ;;
        pi_omv) echo pi_omv ;;
        *) return 1 ;;
    esac
}

usage() {
    cat <<EOF
Usage: $0 <target> <command>
       DOTFILES_TARGET=<name> $0 <command>

Targets — profiles (runbooks):
  arch                 pacman-only headless base (see arch/README.md)
  arch_xfce4           full XFCE workstation + AUR (see arch_xfce4/README.md)
  macos                Homebrew scripts (see macos/README.md)
  crostini             archived no-op apply — see crostini/README.md
  pi_omv               Pi + OMV runbook — see pi_omv/README.md

Targets — hosts (machine identity; resolves profile from hosts/<name>/profile):
  arch-desktop         arch_xfce4 workstation — see hosts/arch-desktop/README.md
  pi-omv               pi_omv NAS — see hosts/pi-omv/README.md
  macbook-pro-m1       macos laptop — see hosts/macbook-pro-m1/README.md

Commands:
  sync                 Sync dotfiles to \$HOME
  bootstrap            Full fresh-install pipeline

Examples:
  $0 arch sync
  $0 arch_xfce4 bootstrap
  $0 arch-desktop bootstrap
  $0 macbook-pro-m1 bootstrap

  export DOTFILES_TARGET=arch
  $0 sync

  export DOTFILES_TARGET=arch-desktop
  $0 sync
EOF
}

if [[ "${1:-}" == help || "${1:-}" == --help || "${1:-}" == -h ]]; then
    usage
    exit 0
fi

HOST=""
if [[ -n "${DOTFILES_TARGET:-}" ]]; then
    TARGET="$DOTFILES_TARGET"
    COMMAND="${1:-}"
else
    if [[ $# -lt 2 ]]; then
        usage >&2
        exit 1
    fi
    TARGET="$1"
    COMMAND="$2"
fi

if [[ -f "$ROOT/hosts/$TARGET/profile" ]]; then
    HOST="$TARGET"
    profile_name="$(tr -d '[:space:]' < "$ROOT/hosts/$HOST/profile")"
    if ! PROFILE_DIR="$(platform_dir "$profile_name")"; then
        echo "Unknown profile in hosts/$HOST/profile: $profile_name" >&2
        exit 1
    fi
elif ! PROFILE_DIR="$(platform_dir "$TARGET")"; then
    echo "Unknown target: $TARGET" >&2
    usage >&2
    exit 1
fi

case "$COMMAND" in
    sync|bootstrap)
        if [[ -n "$HOST" && -x "$ROOT/hosts/$HOST/apply.sh" ]]; then
            "$ROOT/hosts/$HOST/apply.sh" "$COMMAND"
        elif [[ -x "$ROOT/$PROFILE_DIR/apply.sh" ]]; then
            "$ROOT/$PROFILE_DIR/apply.sh" "$COMMAND"
        else
            echo "No apply.sh for $TARGET" >&2
            exit 1
        fi
        ;;
    help|--help|-h)
        usage
        ;;
    "")
        echo "Missing command. Use: sync | bootstrap" >&2
        usage >&2
        exit 1
        ;;
    *)
        echo "Unknown command: $COMMAND" >&2
        usage >&2
        exit 1
        ;;
esac
