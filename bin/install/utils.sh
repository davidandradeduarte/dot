#!/bin/bash

sym_link() {
    if [ -f "$1" ] && [ ! -L "$1" ] && [ ! "$(readlink "$1")" == "$2" ]; then
        mv "$1" "$1.bak"
    fi
    ln -sf "$2" "$1"
}

exit() {
    echo "${NO_COLOR}"
    command exit "$@"
}