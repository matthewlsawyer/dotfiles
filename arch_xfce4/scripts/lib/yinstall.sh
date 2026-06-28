#!/bin/bash

# AUR install helper (yaourt) — arch_xfce4 only.

function yinstall() {
    yaourt -S --noconfirm --needed "$@"
}
