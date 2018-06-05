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

( $CWD/$1/scripts/oh-my-zsh.sh )
( $CWD/$1/scripts/base16.sh )

( $CWD/$1/scripts/postinstall.sh )

unset CWD