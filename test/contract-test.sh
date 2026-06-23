#!/bin/bash

# Contract tests — validates root routing and per-platform install layout.

set -euo pipefail

TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$TEST_DIR/.." && pwd)"

check_executable() {
    local path="$1"
    if [[ ! -x "$path" ]]; then
        echo "missing or not executable: $path" >&2
        exit 1
    fi
}

check_platform_scripts() {
    local platform="$1"
    shift
    local scripts_root="$REPO_ROOT/$platform/scripts"

    echo "==> $platform — entry scripts"
    for script in apply.sh sync.sh bootstrap.sh; do
        check_executable "$scripts_root/$script"
    done

    echo "==> $platform — bootstrap pipeline"
    for script in "$@"; do
        check_executable "$scripts_root/$script"
    done
}

echo "==> root router"
check_executable "$REPO_ROOT/dotfiles.sh"
"$REPO_ROOT/dotfiles.sh" help >/dev/null
"$REPO_ROOT/dotfiles.sh" arch help >/dev/null
"$REPO_ROOT/dotfiles.sh" macos help >/dev/null

if "$REPO_ROOT/dotfiles.sh" nosuchplatform >/dev/null 2>&1; then
    echo "expected unknown platform to fail" >&2
    exit 1
fi

check_platform_scripts arch_xfce4 \
    install/installer.sh \
    install/packages.sh \
    install/desktop.sh \
    install/postinstall.sh

check_platform_scripts macos \
    install/installer.sh \
    install/packages.sh \
    install/postinstall.sh

echo "==> arch_xfce4 — dotfiles and system files"
[[ -f "$REPO_ROOT/arch_xfce4/dotfiles/.zshrc" ]] || {
    echo "missing arch_xfce4/dotfiles/.zshrc" >&2
    exit 1
}
[[ -f "$REPO_ROOT/arch_xfce4/files/etc/X11/xorg.conf.d/20-intel.conf" ]] || {
    echo "missing arch_xfce4/files/etc/X11/xorg.conf.d/20-intel.conf" >&2
    exit 1
}

echo "==> contract-test OK"
