#!/bin/bash

# Entrypoint for the Arch XFCE4 install

CWD="$(pwd)"

# Make sure the user has a configuration argument
if [[ -z $1 ]]; then
    echo "Missing an argument that specifies the configuration"
    exit -1
fi
if [[ ! -d "$CWD/$1" ]]; then
    echo "No directory found that matches the given configuration argument"
    exit -1
fi

( $CWD/$1/scripts/setup.sh )

( $CWD/scripts/sync.sh $@ )

( $CWD/$1/scripts/yaourt.sh )
( $CWD/$1/scripts/packages.sh )

( $CWD/$1/scripts/fonts.sh )

( $CWD/$1/scripts/postinstall.sh )

# Base16 install script requires X11 to be started
# ( $CWD/$1/scripts/base16.sh )

# Installing zsh is interactive so it should be done manually
# ( $CWD/$1/scripts/zsh.sh )

unset CWD