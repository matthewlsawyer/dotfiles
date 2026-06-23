#!/bin/bash

# Pack the full repo as a standalone tarball (same layout as git clone).

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_NAME="$(basename "$REPO_ROOT")"
OUTPUT="${1:-$REPO_ROOT/dotfiles-$(date +%Y%m%d).tar.gz}"

cd "$(dirname "$REPO_ROOT")"

tar czf "$OUTPUT" \
    --exclude="$REPO_NAME/.git" \
    --exclude="$REPO_NAME/test" \
    --exclude="$REPO_NAME/*.tar.gz" \
    --exclude="$REPO_NAME/make-release.sh" \
    "$REPO_NAME"

echo "Created $OUTPUT"
echo "Extract: tar xzf $(basename "$OUTPUT") -C ~"
echo "Install: cd ~/$REPO_NAME && ./dotfiles.sh arch bootstrap"
