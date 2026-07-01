#!/bin/bash

# Contract tests — validates root routing and per-target install layout.
# Organized: root → shared → profiles → hosts.

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

check_file() {
    local path="$1"
    if [[ ! -f "$path" ]]; then
        echo "missing: $path" >&2
        exit 1
    fi
}

check_absent_dir() {
    local path="$1"
    local label="$2"
    if [[ -d "$path" ]]; then
        echo "$label should be removed" >&2
        exit 1
    fi
}

check_profile_scripts() {
    local profile="$1"
    local entry_root="$2"
    local scripts_root="$3"
    shift 3
    local pipeline=("$@")

    echo "    apply.sh"
    check_executable "$entry_root/apply.sh"

    echo "    bootstrap pipeline"
    for script in "${pipeline[@]}"; do
        check_executable "$scripts_root/$script"
    done
}

check_host_profile() {
    local host="$1"
    local expected_profile="$2"

    echo "    profile manifest"
    check_file "$REPO_ROOT/hosts/$host/profile"
    [[ "$(tr -d '[:space:]' < "$REPO_ROOT/hosts/$host/profile")" == "$expected_profile" ]] || {
        echo "hosts/$host/profile should be $expected_profile" >&2
        exit 1
    }
}

# --- root ---

echo "==> root"
check_executable "$REPO_ROOT/dotfiles.sh"
"$REPO_ROOT/dotfiles.sh" help >/dev/null

if "$REPO_ROOT/dotfiles.sh" nosuchtarget sync >/dev/null 2>&1; then
    echo "expected unknown target to fail" >&2
    exit 1
fi

# --- shared ---

echo "==> shared"
echo "    dotfiles"
check_file "$REPO_ROOT/shared/dotfiles/.commonrc"
check_file "$REPO_ROOT/shared/dotfiles/.commonrc.d/00-base.sh"

echo "    extras"
check_executable "$REPO_ROOT/shared/scripts/extras/keys.sh"

# --- profiles ---

echo "==> profile: arch"
check_profile_scripts arch \
    "$REPO_ROOT/arch" \
    "$REPO_ROOT/arch/scripts" \
    bootstrap/installer.sh \
    bootstrap/packages.sh \
    bootstrap/postinstall.sh
echo "    dotfiles"
check_file "$REPO_ROOT/arch/dotfiles/.zshrc"
echo "    optional scripts"
check_executable "$REPO_ROOT/arch/scripts/extras/flatpak.sh"
check_executable "$REPO_ROOT/arch/scripts/system/firewall.sh"
echo "    integration harness"
check_executable "$REPO_ROOT/test/arch/integration-test.sh"

echo "==> profile: arch_xfce4"
check_profile_scripts arch_xfce4 \
    "$REPO_ROOT/arch_xfce4" \
    "$REPO_ROOT/arch_xfce4/scripts" \
    bootstrap/installer.sh \
    bootstrap/packages.sh \
    bootstrap/desktop.sh \
    bootstrap/postinstall.sh
echo "    dotfiles"
check_file "$REPO_ROOT/arch_xfce4/dotfiles/.zshrc"
echo "    optional scripts"
check_executable "$REPO_ROOT/arch_xfce4/scripts/extras/flatpak.sh"
check_executable "$REPO_ROOT/arch_xfce4/scripts/system/firewall.sh"
echo "    layout"
check_absent_dir "$REPO_ROOT/arch_xfce4/scripts/desktop" "arch_xfce4/scripts/desktop/"
check_absent_dir "$REPO_ROOT/arch_xfce4/scripts/hardware" "arch_xfce4/scripts/hardware/"
echo "    integration harness"
check_executable "$REPO_ROOT/test/arch_xfce4/integration-test.sh"

echo "==> profile: macos"
check_profile_scripts macos \
    "$REPO_ROOT/macos" \
    "$REPO_ROOT/macos/scripts" \
    bootstrap/installer.sh \
    bootstrap/packages.sh \
    bootstrap/postinstall.sh
echo "    dotfiles"
check_file "$REPO_ROOT/macos/dotfiles/.zshrc"

echo "==> profile: pi_omv"
check_profile_scripts pi_omv \
    "$REPO_ROOT/pi_omv" \
    "$REPO_ROOT/pi_omv/scripts" \
    bootstrap/setup.sh \
    bootstrap/omv.sh \
    bootstrap/postinstall.sh
echo "    routing"
"$REPO_ROOT/dotfiles.sh" pi_omv help >/dev/null
echo "    optional scripts"
check_executable "$REPO_ROOT/pi_omv/scripts/extras/samba.sh"
check_executable "$REPO_ROOT/pi_omv/scripts/extras/omv-extras.sh"
echo "    layout"
check_absent_dir "$REPO_ROOT/pi_omv/scripts/system" "pi_omv/scripts/system/"
echo "    integration harness"
check_executable "$REPO_ROOT/test/pi_omv/integration-test.sh"

echo "==> profile: crostini (archived)"
echo "    apply.sh"
check_executable "$REPO_ROOT/crostini/apply.sh"
echo "    routing (no-op)"
"$REPO_ROOT/dotfiles.sh" crostini sync 2>/dev/null
"$REPO_ROOT/dotfiles.sh" crostini bootstrap 2>/dev/null

# --- hosts ---

echo "==> host: arch-desktop"
echo "    apply.sh"
check_executable "$REPO_ROOT/hosts/arch-desktop/apply.sh"
check_host_profile arch-desktop arch_xfce4

echo "==> host: macbook-pro-m1"
echo "    apply.sh"
check_executable "$REPO_ROOT/hosts/macbook-pro-m1/apply.sh"
check_host_profile macbook-pro-m1 macos

echo "==> host: pi-omv (manifest-only)"
check_host_profile pi-omv pi_omv
if [[ -f "$REPO_ROOT/hosts/pi-omv/apply.sh" ]]; then
    echo "hosts/pi-omv/apply.sh should not exist (manifest-only host)" >&2
    exit 1
fi
"$REPO_ROOT/dotfiles.sh" pi-omv help >/dev/null

echo "==> contract-test OK"
