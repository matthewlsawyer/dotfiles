#!/bin/bash

# Root router — profiles or hosts → apply.sh (sync | bootstrap).
#
# Usage:
#   ./dotfiles.sh arch sync
#   ./dotfiles.sh arch-desktop bootstrap
#   DOTFILES_HOST=arch-desktop ./dotfiles.sh sync

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

host_dir() {
    case "$1" in
        arch-desktop) echo arch-desktop ;;
        pi-omv) echo pi-omv ;;
        macbook-pro-m1) echo macbook-pro-m1 ;;
        *) return 1 ;;
    esac
}

platform_root() {
    echo "$ROOT/$1"
}

usage() {
    cat <<EOF
Usage: $0 <target> <command>
       DOTFILES_PLATFORM=<profile> $0 <command>
       DOTFILES_HOST=<host> $0 <command>

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
  $0 pi-omv sync
  $0 macbook-pro-m1 bootstrap

  export DOTFILES_PLATFORM=arch
  $0 sync

  export DOTFILES_HOST=arch-desktop
  $0 sync
EOF
}

sync_dotfiles_layers() {
    local profile_dir="$1"
    local host_name="${2:-}"
    local profile_root
    profile_root="$(platform_root "$profile_dir")"

    if [[ -d "$ROOT/shared/dotfiles" ]]; then
        rsync -avh --no-perms "$ROOT/shared/dotfiles/" ~/
    fi
    if [[ -d "$profile_root/dotfiles" ]]; then
        rsync -avh --no-perms "$profile_root/dotfiles/" ~/
    fi
    if [[ -n "$host_name" && -d "$ROOT/hosts/$host_name/dotfiles" ]]; then
        rsync -avh --no-perms "$ROOT/hosts/$host_name/dotfiles/" ~/
    fi
}

host_etc_hint() {
    local host_name="$1"
    local etc_dir="$ROOT/hosts/$host_name/files/etc"
    if [[ -d "$etc_dir" ]]; then
        echo ""
        echo "Host system files (manual deploy to /):"
        echo "  $etc_dir"
        echo "  e.g. sudo cp -r $etc_dir/* /etc/"
    fi
}

runbook_only_message() {
    local profile_dir="$1"
    local host_name="${2:-}"
    echo "Profile '$profile_dir' is runbook-only — no apply.sh." >&2
    echo "See $profile_dir/README.md" >&2
    if [[ -n "$host_name" ]]; then
        echo "Host notes: hosts/$host_name/README.md" >&2
    fi
}

resolve_target_and_args() {
    HOST=""
    TARGET_ARG=""

    if [[ "${1:-}" == help || "${1:-}" == --help || "${1:-}" == -h ]]; then
        usage
        exit 0
    fi

    if [[ -n "${DOTFILES_HOST:-}" ]]; then
        TARGET_ARG="$DOTFILES_HOST"
        REMAINING_ARGS=("$@")
        return
    fi

    if [[ -n "${DOTFILES_PLATFORM:-}" ]]; then
        TARGET_ARG="$DOTFILES_PLATFORM"
        REMAINING_ARGS=("$@")
        return
    fi

    if [[ $# -lt 2 ]]; then
        usage >&2
        exit 1
    fi

    TARGET_ARG="$1"
    shift
    REMAINING_ARGS=("$@")
}

resolve_target() {
    local name="$1"
    local resolved="$name"

    if mapped="$(host_dir "$name" 2>/dev/null)"; then
        resolved="$mapped"
    fi

    if [[ -f "$ROOT/hosts/$resolved/profile" ]]; then
        HOST="$resolved"
        PROFILE_DIR="$(tr -d '[:space:]' < "$ROOT/hosts/$HOST/profile")"
        if ! canonical="$(platform_dir "$PROFILE_DIR" 2>/dev/null)"; then
            echo "Unknown profile in hosts/$HOST/profile: $PROFILE_DIR" >&2
            exit 1
        fi
        PROFILE_DIR="$canonical"
        return 0
    fi

    if PROFILE_DIR="$(platform_dir "$name")"; then
        return 0
    fi

    echo "Unknown target: $name" >&2
    usage >&2
    exit 1
}

resolve_target_and_args "$@"
resolve_target "$TARGET_ARG"

COMMAND="${REMAINING_ARGS[0]:-}"
PLATFORM_ROOT="$(platform_root "$PROFILE_DIR")"

case "$COMMAND" in
    sync|bootstrap)
        APPLY="$PLATFORM_ROOT/apply.sh"
        if [[ -x "$APPLY" ]]; then
            "$APPLY" "$COMMAND"
            if [[ -n "$HOST" ]]; then
                if [[ -d "$ROOT/hosts/$HOST/dotfiles" ]]; then
                    rsync -avh --no-perms "$ROOT/hosts/$HOST/dotfiles/" ~/
                fi
                host_etc_hint "$HOST"
            fi
        else
            if [[ "$COMMAND" == "bootstrap" ]]; then
                runbook_only_message "$PROFILE_DIR" "$HOST"
                exit 1
            fi
            # sync — layers only for runbook-only profiles
            sync_dotfiles_layers "$PROFILE_DIR" "$HOST"
            runbook_only_message "$PROFILE_DIR" "$HOST"
            host_etc_hint "$HOST"
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
