#!/bin/sh

install_fzf() {
    echo "Installing fzf..."
    if [ -d "$HOME/.fzf" ]; then
        echo "fzf already installed."
        return
    fi
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
}
