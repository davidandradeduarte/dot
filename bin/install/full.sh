#!/bin/sh

full() {
    if [ "$OS" == "Darwin" ]; then
        full_macos
    elif [ "$OS" == "Linux" ]; then
        echo "Linux not implemented yet"
    fi
}
