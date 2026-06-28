#!/bin/bash

# Optional — Python 3.14 runtime only.
# Project deps: python3 -m venv .venv — never pip install globally on Homebrew Python.
# CLI tools: pkg_install or uv tool install / uvx (uv installed by bootstrap).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
# shellcheck source=../lib/functions.sh
. "$SCRIPT_DIR/../lib/functions.sh"

pkg_install python@3.14
brew link python@3.14
