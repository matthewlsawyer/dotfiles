#!/bin/bash

# Contract: bootstrap pipeline step 3 — uv.sh
# uv for ad-hoc CLI tools: uv tool install <tool>, one-offs via uvx

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"

brew install uv
