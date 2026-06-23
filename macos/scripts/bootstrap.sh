#!/bin/bash

# Contract: bootstrap — runs the install pipeline in fixed order.
#
# Pipeline (do not reorder — see install/README.md):
#   installer.sh → packages.sh → sync.sh → postinstall.sh
#
# Invoked by apply.sh bootstrap.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/init.sh
. "$SCRIPT_DIR/lib/init.sh"
cd "$DOTFILES_SCRIPTS_ROOT"

# Bootstrap pipeline contract — keep in sync with install/README.md
BOOTSTRAP_PIPELINE=(
    install/installer.sh
    install/packages.sh
    sync.sh
    install/postinstall.sh
)

run_step() {
    echo "==> $1"
    shift
    "$@"
}

for step in "${BOOTSTRAP_PIPELINE[@]}"; do
    run_step "$step" "./$step"
done

echo "==> bootstrap.sh complete"
cat <<'EOF'

Recommended optional:
  ./apps/dev.sh && ./apps/browsers.sh
  ./apps/awscli.sh

See scripts/README.md for details.
EOF
