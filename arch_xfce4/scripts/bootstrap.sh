#!/bin/bash

# Internal: bootstrap — orchestrates install pipeline then sync.
#
# Pipeline (see install/README.md):
#   installer.sh → packages.sh → desktop.sh → sync.sh → postinstall.sh
#
# Invoked by apply.sh bootstrap.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/init.sh
. "$SCRIPT_DIR/lib/init.sh"

BOOTSTRAP_PIPELINE=(
    "$DOTFILES_SCRIPTS_ROOT/install/installer.sh"
    "$DOTFILES_SCRIPTS_ROOT/install/packages.sh"
    "$DOTFILES_SCRIPTS_ROOT/install/desktop.sh"
    "$DOTFILES_SCRIPTS_ROOT/sync.sh"
    "$DOTFILES_SCRIPTS_ROOT/install/postinstall.sh"
)

run_step() {
    echo "==> $1"
    shift
    "$@"
}

for step in "${BOOTSTRAP_PIPELINE[@]}"; do
    run_step "$(basename "$step")" "$step"
done

echo "==> bootstrap complete"
platform="$(basename "$DOTFILES_PLATFORM_ROOT")"
cat <<EOF

Recommended optional (NVIDIA + dev tooling):
  cd ${platform}/scripts
  ./hardware/graphics-nvidia.sh
  ./apps/dev.sh && ./apps/utilities.sh

See README.md for the full module list.
EOF
