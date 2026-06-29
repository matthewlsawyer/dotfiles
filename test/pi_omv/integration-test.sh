#!/bin/bash

# Integration test: pi_omv phase 1 (setup.sh + preinstall) in Debian Bookworm.
# Does not run omv.sh — OMV rejects container installs; validate on real Pi.
#
# Usage:
#   ./integration-test.sh

set -euo pipefail

TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$TEST_DIR/../.." && pwd)"
IMAGE="${IMAGE:-dotfiles-test-pi-omv}"

if ! command -v docker >/dev/null; then
    echo "docker not found" >&2
    exit 1
fi

if [[ $# -gt 0 ]]; then
    echo "Usage: $0" >&2
    exit 1
fi

echo "==> build ($IMAGE)"
docker build -t "$IMAGE" -f "$TEST_DIR/Dockerfile" "$TEST_DIR"

echo "==> stage repo (exclude .git, graphify-out, .cursor)"
STAGING="$(mktemp -d)"
cleanup() { rm -rf "$STAGING"; }
trap cleanup EXIT
rsync -a \
    --exclude='.git' \
    --exclude='graphify-out' \
    --exclude='.cursor' \
    "$REPO_ROOT/" "$STAGING/"

echo "==> phase 1: sync + setup.sh"
docker run --rm \
    -v "$STAGING:/dotfiles:ro" \
    "$IMAGE" \
    bash -c '
set -euo pipefail
cd /dotfiles
./dotfiles.sh pi_omv sync
test -f ~/.commonrc || { echo "missing ~/.commonrc after sync" >&2; exit 1; }
./pi_omv/scripts/bootstrap/setup.sh 2>&1 | tee /tmp/setup.log
command -v vim git wget jq >/dev/null
while IFS= read -r -d "" script; do
    bash -n "$script"
done < <(find pi_omv/scripts -name "*.sh" -print0)
'

echo "==> integration-test OK"
