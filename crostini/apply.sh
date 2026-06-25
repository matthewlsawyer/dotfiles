#!/bin/bash

# Platform interface — archived no-op stub (sync | bootstrap).
#
# Invoked by dotfiles.sh crostini sync | bootstrap. Exits 0; see README.md for legacy scripts.

set -euo pipefail

apply_usage() {
    cat <<EOF
Usage: $0 sync|bootstrap|help

  sync        Archived — no-op
  bootstrap   Archived — no-op

Platform is EOL. See README.md for the legacy manual script sequence.

Or: dotfiles.sh crostini sync | bootstrap
EOF
}

archived_notice() {
    echo "crostini is archived (EOL stack). No-op — see crostini/README.md for legacy steps." >&2
}

case "${1:-}" in
    sync|bootstrap)
        archived_notice
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
