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
    local entry_root="$2"
    local pipeline_root="$3"
    shift 3
    local scripts=("$@")

    echo "==> $platform — entry script"
    check_executable "$entry_root/apply.sh"

    echo "==> $platform — internal glue"
    check_executable "$pipeline_root/sync.sh"
    check_executable "$pipeline_root/bootstrap.sh"

    echo "==> $platform — bootstrap pipeline"
    for script in "${scripts[@]}"; do
        check_executable "$pipeline_root/$script"
    done
}

echo "==> root router"
check_executable "$REPO_ROOT/dotfiles.sh"
"$REPO_ROOT/dotfiles.sh" help >/dev/null

if "$REPO_ROOT/dotfiles.sh" nosuchtarget sync >/dev/null 2>&1; then
    echo "expected unknown target to fail" >&2
    exit 1
fi

check_platform_scripts arch \
    "$REPO_ROOT/arch" \
    "$REPO_ROOT/arch/scripts" \
    install/packages.sh \
    install/postinstall.sh

check_platform_scripts macos \
    "$REPO_ROOT/macos" \
    "$REPO_ROOT/macos/scripts" \
    install/installer.sh \
    install/packages.sh \
    install/uv.sh \
    install/postinstall.sh

check_platform_scripts arch_xfce4 \
    "$REPO_ROOT/arch_xfce4" \
    "$REPO_ROOT/arch_xfce4/scripts" \
    install/installer.sh \
    install/packages.sh \
    install/desktop.sh \
    install/postinstall.sh

echo "==> crostini — archived entry script"
check_executable "$REPO_ROOT/crostini/apply.sh"

echo "==> crostini — routing (no-op)"
"$REPO_ROOT/dotfiles.sh" crostini sync 2>/dev/null
"$REPO_ROOT/dotfiles.sh" crostini bootstrap 2>/dev/null

echo "==> arch — dotfiles"
[[ -f "$REPO_ROOT/arch/dotfiles/.zshrc" ]] || {
    echo "missing arch/dotfiles/.zshrc" >&2
    exit 1
}

echo "==> arch_xfce4 — dotfiles"
[[ -f "$REPO_ROOT/arch_xfce4/dotfiles/.zshrc" ]] || {
    echo "missing arch_xfce4/dotfiles/.zshrc" >&2
    exit 1
}

echo "==> shared — dotfiles"
[[ -f "$REPO_ROOT/shared/dotfiles/.commonrc" ]] || {
    echo "missing shared/dotfiles/.commonrc" >&2
    exit 1
}

echo "==> hosts — manifests"
[[ -f "$REPO_ROOT/hosts/arch-desktop/profile" ]] || {
    echo "missing hosts/arch-desktop/profile" >&2
    exit 1
}
[[ "$(tr -d '[:space:]' < "$REPO_ROOT/hosts/arch-desktop/profile")" == "arch_xfce4" ]] || {
    echo "hosts/arch-desktop/profile should be arch_xfce4" >&2
    exit 1
}

[[ -f "$REPO_ROOT/hosts/macbook-pro-m1/profile" ]] || {
    echo "missing hosts/macbook-pro-m1/profile" >&2
    exit 1
}
[[ "$(tr -d '[:space:]' < "$REPO_ROOT/hosts/macbook-pro-m1/profile")" == "macos" ]] || {
    echo "hosts/macbook-pro-m1/profile should be macos" >&2
    exit 1
}

echo "==> arch — integration harness"
check_executable "$REPO_ROOT/test/arch/integration-test.sh"

echo "==> contract-test OK"
