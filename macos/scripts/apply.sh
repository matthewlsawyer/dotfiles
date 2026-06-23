#!/bin/bash

# Contract: apply — platform entry point for dotfiles.sh and direct invocation.
#
#   (default)  sync.sh
#   bootstrap  exec bootstrap.sh
#   help       apply_usage()

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

apply_usage() {
    cat <<EOF
Usage: $0 [bootstrap|help]

  (default)   Apply — sync dotfiles to \$HOME (none yet for macOS)
  bootstrap   Pipeline: installer → packages → sync → postinstall

See scripts/install/README.md and macos/README.md.
EOF
}

case "${1:-}" in
    bootstrap)
        exec "$SCRIPT_DIR/bootstrap.sh"
        ;;
    help|--help|-h)
        apply_usage
        ;;
    "")
        echo "==> sync.sh"
        "$SCRIPT_DIR/sync.sh"
        echo "==> apply complete"
        ;;
    *)
        echo "Unknown command: $1" >&2
        apply_usage >&2
        exit 1
        ;;
esac
