#!/bin/bash

# Optional — Nerd Fonts download and install.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"

FONTS=("DejaVuSansMono" "DroidSansMono" "FiraCode" "FiraMono" "Hack")

# Get latest release
TAG_NAME=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq -r ".tag_name")

FONT_DIR=$HOME/.local/share/fonts
mkdir -p $FONT_DIR

for f in "${FONTS[@]}"
do
    echo "https://github.com/ryanoasis/nerd-fonts/releases/download/$TAG_NAME/$f.zip"
    curl -Lo "$FONT_DIR/$f.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/$TAG_NAME/$f.zip"
    yes A | unzip "$FONT_DIR/$f.zip" -d "$FONT_DIR/$f"
    rm -f "$FONT_DIR/$f.zip"
done

unset FONTS
unset TAG_NAME
unset FONT_DIR
