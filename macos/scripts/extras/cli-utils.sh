#!/bin/bash

# Optional — HTTP client and line-ending conversion.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"

brew install httpie mac2unix
