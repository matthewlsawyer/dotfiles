#!/bin/bash

# uv.sh — uv for ad-hoc CLI tools (uv tool install, uvx).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
# shellcheck source=../lib/functions.sh
. "$SCRIPT_DIR/../lib/functions.sh"

pkg_install uv
