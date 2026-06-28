#!/bin/bash

# Optional — Python 3.14 runtime (project deps go in venv, not global pip).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"

brew install python@3.14
brew link python@3.14
