#!/bin/bash

# Integration test: ./dotfiles.sh arch bootstrap in a throwaway archlinux container.
# Runs the real bootstrap pipeline — not a separate install path.
#
# Usage:
#   ./integration-test.sh

set -euo pipefail

TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$TEST_DIR/../.." && pwd)"
IMAGE="${IMAGE:-dotfiles-test-arch}"
DOCKER_PLATFORM="${DOCKER_PLATFORM:-linux/amd64}"
PACMAN_CACHE_VOLUME="${PACMAN_CACHE_VOLUME:-dotfiles-pacman-cache}"

if ! command -v docker >/dev/null; then
    echo "docker not found" >&2
    exit 1
fi

if [[ $# -gt 0 ]]; then
    echo "Usage: $0" >&2
    exit 1
fi

echo "==> build ($IMAGE)"
docker build \
    --platform "$DOCKER_PLATFORM" \
    --build-arg "DOCKER_PLATFORM=$DOCKER_PLATFORM" \
    -t "$IMAGE" \
    -f "$TEST_DIR/Dockerfile" \
    "$TEST_DIR"

echo "==> stage repo (exclude .git, graphify-out, .cursor)"
STAGING="$(mktemp -d)"
cleanup() { rm -rf "$STAGING"; }
trap cleanup EXIT
rsync -a \
    --exclude='.git' \
    --exclude='graphify-out' \
    --exclude='.cursor' \
    "$REPO_ROOT/" "$STAGING/"

echo "==> ./dotfiles.sh arch bootstrap"
docker run --rm \
    --platform "$DOCKER_PLATFORM" \
    -v "$STAGING:/dotfiles:ro" \
    -v "$PACMAN_CACHE_VOLUME:/var/cache/pacman" \
    "$IMAGE" \
    bash -c '
set -euo pipefail
cd /dotfiles
./dotfiles.sh arch bootstrap 2>&1 | tee /tmp/bootstrap.log
grep -q "bootstrap complete" /tmp/bootstrap.log
test -f ~/.zshrc || { echo "missing ~/.zshrc after sync" >&2; exit 1; }
command -v rsync git >/dev/null
'

echo "==> integration-test OK"
