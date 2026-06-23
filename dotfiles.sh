#!/bin/bash

# Root router — execs into $platform/scripts/apply.sh (contract entry point).
# Platform-agnostic; install logic stays in each platform's scripts/.
#
# Usage:
#   ./dotfiles.sh arch              # arch_xfce4/scripts/apply.sh
#   ./dotfiles.sh arch bootstrap
#   ./dotfiles.sh macos
#   DOTFILES_PLATFORM=arch ./dotfiles.sh
#   DOTFILES_PLATFORM=arch ./dotfiles.sh bootstrap

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

platform_dir() {
    case "$1" in
        arch|arch_xfce4) echo arch_xfce4 ;;
        macos) echo macos ;;
        crostini) echo crostini ;;
        pi|pi_omv) echo pi_omv ;;
        *) return 1 ;;
    esac
}

usage() {
    cat <<EOF
Usage: $0 <platform> [command ...]
       DOTFILES_PLATFORM=<platform> $0 [command ...]

Platforms:
  arch, macos          active — apply / sync / bootstrap (see platform scripts/README.md)
  crostini             archived — apply.sh exits with pointer to README
  pi                   runbook only — no scripts/apply.sh

Examples:
  $0 arch                    apply dotfiles (sync)
  $0 arch bootstrap          full fresh-install pipeline
  $0 macos                   Homebrew packages
  $0 macos bootstrap         Homebrew + packages

  export DOTFILES_PLATFORM=arch
  $0                         apply dotfiles (platform from env)
  $0 bootstrap               bootstrap (platform from env)

DOTFILES_PLATFORM skips the platform argument — useful in shell profile or scripts
when you always run on the same OS context.
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

    if [[ $# -lt 1 ]]; then
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

APPLY="$ROOT/$DIR/scripts/apply.sh"
if [[ ! -x "$APPLY" ]]; then
    echo "No scripts/apply.sh for platform '$PLATFORM' ($DIR)." >&2
    echo "See $DIR/README.md — may be archived or runbook-only." >&2
    exit 1
fi

exec "$APPLY" "${REMAINING_ARGS[@]}"
