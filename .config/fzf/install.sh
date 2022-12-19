#!/bin/sh

install_fzf() {
    set_error_trap
    echo_inf "Installing fzf..."
    if [ -d "$HOME/.fzf" ]; then
        echo_warn "$HOME/.fzf already exists. Skipping fzf installation."
        return
    fi
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
}
