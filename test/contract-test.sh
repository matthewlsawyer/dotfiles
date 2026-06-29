#!/bin/bash

# Contract tests — validates root routing and per-target install layout.

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

check_profile_scripts() {
    local profile="$1"
    local entry_root="$2"
    local scripts_root="$3"
    shift 3
    local pipeline=("$@")

    echo "==> $profile — apply.sh"
    check_executable "$entry_root/apply.sh"

    echo "==> $profile — bootstrap pipeline"
    for script in "${pipeline[@]}"; do
        check_executable "$scripts_root/$script"
    done
}

echo "==> root router"
check_executable "$REPO_ROOT/dotfiles.sh"
"$REPO_ROOT/dotfiles.sh" help >/dev/null

if "$REPO_ROOT/dotfiles.sh" nosuchtarget sync >/dev/null 2>&1; then
    echo "expected unknown target to fail" >&2
    exit 1
fi

check_profile_scripts arch \
    "$REPO_ROOT/arch" \
    "$REPO_ROOT/arch/scripts" \
    bootstrap/installer.sh \
    bootstrap/packages.sh \
    bootstrap/postinstall.sh

check_profile_scripts macos \
    "$REPO_ROOT/macos" \
    "$REPO_ROOT/macos/scripts" \
    bootstrap/installer.sh \
    bootstrap/packages.sh \
    bootstrap/uv.sh \
    bootstrap/python.sh \
    bootstrap/postinstall.sh

check_profile_scripts arch_xfce4 \
    "$REPO_ROOT/arch_xfce4" \
    "$REPO_ROOT/arch_xfce4/scripts" \
    bootstrap/installer.sh \
    bootstrap/packages.sh \
    bootstrap/desktop.sh \
    bootstrap/postinstall.sh

echo "==> macbook-pro-m1 — host apply.sh"
check_executable "$REPO_ROOT/hosts/macbook-pro-m1/apply.sh"

echo "==> arch-desktop — host apply.sh"
check_executable "$REPO_ROOT/hosts/arch-desktop/apply.sh"

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
[[ -f "$REPO_ROOT/shared/dotfiles/.commonrc.d/00-base.sh" ]] || {
    echo "missing shared/dotfiles/.commonrc.d/00-base.sh" >&2
    exit 1
}

echo "==> macos — dotfiles"
[[ -f "$REPO_ROOT/macos/dotfiles/.zshrc" ]] || {
    echo "missing macos/dotfiles/.zshrc" >&2
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

echo "==> arch — extras"
check_executable "$REPO_ROOT/arch/scripts/extras/flatpak.sh"

echo "==> arch_xfce4 — extras"
check_executable "$REPO_ROOT/arch_xfce4/scripts/extras/flatpak.sh"

echo "==> shared — extras"
check_executable "$REPO_ROOT/shared/scripts/extras/keys.sh"

echo "==> arch_xfce4 — no legacy desktop/ or hardware/ dirs"
[[ ! -d "$REPO_ROOT/arch_xfce4/scripts/desktop" ]] || {
    echo "arch_xfce4/scripts/desktop/ should be removed" >&2
    exit 1
}
[[ ! -d "$REPO_ROOT/arch_xfce4/scripts/hardware" ]] || {
    echo "arch_xfce4/scripts/hardware/ should be removed" >&2
    exit 1
}

echo "==> arch — integration harness"
check_executable "$REPO_ROOT/test/arch/integration-test.sh"

echo "==> contract-test OK"
