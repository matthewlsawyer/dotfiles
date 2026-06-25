#!/bin/bash

# Platform interface — sync | bootstrap.
#
#   sync        dotfiles/ → $HOME
#   bootstrap   full install pipeline
#
# Invoked by dotfiles.sh arch sync | bootstrap.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

apply_usage() {
    cat <<EOF
Usage: $0 sync|bootstrap|help

  sync        Dotfiles → \$HOME
  bootstrap   Full install pipeline

Or: dotfiles.sh arch sync | bootstrap

See README.md.
EOF
}

case "${1:-}" in
    sync)
        exec "$SCRIPT_DIR/scripts/sync.sh"
        ;;
    bootstrap)
        exec "$SCRIPT_DIR/scripts/bootstrap.sh"
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
