#!/bin/bash

# Optional — editors, runtimes, and dev tooling.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
# shellcheck source=../lib/functions.sh
. "$SCRIPT_DIR/../lib/functions.sh"

pkg_install --cask visual-studio-code
pkg_install --cask cursor
pkg_install --cask docker

# Node (npm included)
pkg_install node

# Optional VS Code extensions — uncomment as needed
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
# code --install-extension rbbit.typescript-hero
# code --install-extension eg2.vscode-npm-script
# code --install-extension ms-vscode.csharp
# code --install-extension eg2.tslint
# code --install-extension ajhyndman.jslint
# code --install-extension dbaeumer.vscode-eslint

# Optional languages — uncomment as needed
# pkg_install go
# pkg_install gcc
# pkg_install kotlin

# Optional npm globals — uncomment as needed
# npm install -g gulp less
# npm install -g typescript @angular/cli
# npm install -g tslint eslint jslint
