#!/bin/bash

full() {
    if [ "$OS" == "Darwin" ]; then
        full_macos
    elif [ "$OS" == "Linux" ]; then
        echo "Linux not supported yet."
    fi

    sym_link "$HOME/.bin" "$dir/.bin"
}
