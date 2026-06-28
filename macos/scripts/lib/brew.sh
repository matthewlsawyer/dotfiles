#!/bin/bash

# pkg_install contract — Homebrew implementation (see shared/README.md#install-contract)

function pkg_install() {
    brew install "$@"
}
