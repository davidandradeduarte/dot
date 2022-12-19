#!/bin/bash

# sym_link <target> <source>
# Creates a symlink from <target> to <source>.
sym_link() {
    set_error_trap
    if [ -f "$1" ] && [ ! -L "$1" ] && [ ! "$(readlink "$1")" == "$2" ]; then
        epoch=$(date +%s)
        echo_inf "Backing up $1 to $1.bak.$epoch"
        mv "$1" "$1.bak.$epoch"
    fi
    echo_inf "Creating symlink $1 -> $2"
    ln -sf "$2" "$1"
}

# create_dir <dir>
# Creates a directory if it doesn't exist.
create_dir() {
    set_error_trap
    if [ ! -d "$1" ]; then
        echo_inf "Creating directory $1"
        mkdir -p "$1"
    fi
}
