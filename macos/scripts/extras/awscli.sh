#!/bin/bash

# Optional — AWS CLI v1 via bundled installer (not Homebrew).
# https://docs.aws.amazon.com/cli/latest/userguide/cli-install-macos.html

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"

curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
rm -fr awscli-bundle awscli-bundle.zip
