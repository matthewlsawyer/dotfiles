#!/bin/bash

# Optional — editors, runtimes, and dev tooling.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

aur_install visual-studio-code-bin

pkg_install docker docker-compose
sudo usermod -aG docker "$USER"

# Node (npm included in nodejs package)
pkg_install nodejs
NPM_PACKAGES="${HOME}/.npm-packages"
mkdir -p "$NPM_PACKAGES"
npm config set prefix "$NPM_PACKAGES"

# Optional VS Code extensions — uncomment as needed
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
# code --install-extension nrwl.angular-console

# Optional languages / tools — uncomment as needed
# pkg_install pygmentize
# pkg_install aws-cli
# pkg_install redis
# pkg_install python
# pkg_install qtcreator

# Optional npm globals — uncomment as needed
# npm install -g typescript @angular/cli
# npm install -g tslint eslint jslint
