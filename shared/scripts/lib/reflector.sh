#!/bin/bash

# reflector_mirrors — rewrite pacman mirrorlist before full sync.
# Source after functions.sh (sudov active). Skips in Docker / when REFLECTOR_SKIP=1.

reflector_mirrors() {
    if [[ -n "${REFLECTOR_SKIP:-}" ]] || [[ -f /.dockerenv ]]; then
        echo "reflector: skipped (REFLECTOR_SKIP or container)"
        return 0
    fi

    local country="${REFLECTOR_COUNTRY:-US}"

    sudo pacman -Sy --noconfirm reflector
    sudo reflector --country "$country" --age 12 --protocol https --sort rate \
        --save /etc/pacman.d/mirrorlist
}
