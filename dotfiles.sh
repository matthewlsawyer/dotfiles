#!/bin/bash

# Root router — execs into each platform's apply.sh (sync | bootstrap).
#
# Usage:
#   ./dotfiles.sh arch sync
#   ./dotfiles.sh arch bootstrap
#   DOTFILES_PLATFORM=arch ./dotfiles.sh sync

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

platform_dir() {
    case "$1" in
        arch) echo arch ;;
        arch_xfce4) echo arch_xfce4 ;;
        macos) echo macos ;;
        crostini) echo crostini ;;
        pi|pi_omv) echo pi_omv ;;
        *) return 1 ;;
    esac
}

platform_root() {
    echo "$ROOT/$1"
}

usage() {
    cat <<EOF
Usage: $0 <platform> <command>
       DOTFILES_PLATFORM=<platform> $0 <command>

Platforms:
  arch                 pacman-only headless base (see arch/README.md)
  arch_xfce4           full XFCE workstation + AUR (see arch_xfce4/README.md)
  macos                Homebrew scripts (see macos/README.md)
  crostini             archived no-op apply — see crostini/README.md
  pi                   runbook only — no scripts/

Commands:
  sync                 Sync dotfiles to \$HOME
  bootstrap            Full fresh-install pipeline

Examples:
  $0 arch sync
  $0 arch bootstrap
  $0 arch_xfce4 bootstrap
  $0 macos sync
  $0 macos bootstrap
  $0 crostini sync              # archived — no-op

  export DOTFILES_PLATFORM=arch
  $0 sync
  $0 bootstrap
EOF
}

resolve_platform_and_args() {
    if [[ "${1:-}" == help || "${1:-}" == --help || "${1:-}" == -h ]]; then
        usage
        exit 0
    fi

    if [[ -n "${DOTFILES_PLATFORM:-}" ]]; then
        PLATFORM="$DOTFILES_PLATFORM"
        REMAINING_ARGS=("$@")
        return
    fi

    if [[ $# -lt 2 ]]; then
        usage >&2
        exit 1
    fi

    PLATFORM="$1"
    shift
    REMAINING_ARGS=("$@")
}

resolve_platform_and_args "$@"

if ! DIR="$(platform_dir "$PLATFORM")"; then
    echo "Unknown platform: $PLATFORM" >&2
    usage >&2
    exit 1
fi

PLATFORM_ROOT="$(platform_root "$DIR")"
COMMAND="${REMAINING_ARGS[0]:-}"

case "$COMMAND" in
    sync|bootstrap)
        APPLY="$PLATFORM_ROOT/apply.sh"
        if [[ ! -x "$APPLY" ]]; then
            echo "No apply.sh for platform '$PLATFORM' ($DIR)." >&2
            echo "See $DIR/README.md — may be archived or runbook-only." >&2
            exit 1
        fi
        exec "$APPLY" "$COMMAND"
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
