#!/bin/bash

# Optional — web browser.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
# shellcheck source=../lib/functions.sh
. "$SCRIPT_DIR/../lib/functions.sh"

pkg_install --cask google-chrome
