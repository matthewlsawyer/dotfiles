#!/bin/bash

# Keep sudo credential alive during long installs.

# Already running in this shell (e.g. functions.sh + postinstall both source sudov).
if [[ -n "${SUDOV_PID:-}" ]] && kill -0 "$SUDOV_PID" 2>/dev/null; then
    sudo -v
    return 0 2>/dev/null || exit 0
fi

sudo -v

_sudov_cleanup() {
    kill "$SUDOV_PID" 2>/dev/null
    pkill -P "$SUDOV_PID" 2>/dev/null
    wait "$SUDOV_PID" 2>/dev/null || true
}

(
    while true; do
        sudo -n true 2>/dev/null || exit 0
        # read -t avoids orphan `sleep` children when this subshell is killed on EXIT.
        read -r -t 60 -N 0 </dev/null || true
    done
) &
SUDOV_PID=$!

trap '_sudov_cleanup' EXIT
