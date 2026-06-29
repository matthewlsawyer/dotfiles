#!/bin/bash

# Optional — VS Code extension reference (install manually with code --install-extension).
# Host-only — machine-specific; not part of macos profile.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"

# Packages: ./apps/bundle.sh (Brewfile.apps). Node via brew — no version manager.

# Optional VS Code extensions — uncomment and run deliberately; not bootstrap
# code --install-extension eamodio.gitlens
# code --install-extension mikael.angular-beastcode
# code --install-extension PeterJausovec.vscode-docker
# code --install-extension EditorConfig.editorconfig
# code --install-extension ms-vscode.go
# code --install-extension redhat.java
# code --install-extension mathiasfrohlich.kotlin
# code --install-extension yzhang.markdown-all-in-one
# code --install-extension ms-python.python
# code --install-extension robinbentley.sass-indented
# code --install-extension eg2.vscode-npm-script
# code --install-extension dbaeumer.vscode-eslint

# Optional languages — uncomment as needed
# brew install go
# brew install gcc
# brew install kotlin

# Optional npm globals — uncomment as needed
# npm install -g typescript @angular/cli eslint
