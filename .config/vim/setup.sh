#!/bin/bash

setup_vim() {
    set_error_trap
    echo_inf "Setting up ${GREEN}vim${NO_COLOR}..."

    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    sym_link "$HOME/.vimrc" "$dir/.config/vim/.vimrc"

    echo_inf "Installing ${GREEN}vim-plug${NO_COLOR} plugins..."
    vim +'PlugInstall --sync' +qa
}
