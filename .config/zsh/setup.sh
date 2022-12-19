#!/bin/bash

setup_zsh() {
    set_error_trap
    echo_inf "Setting up ${GREEN}zsh${NO_COLOR}..."

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo_inf "Installing ${GREEN}oh-my-zsh${NO_COLOR}..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    sym_link "$HOME/.zshrc" "$dir/.config/zsh/.zshrc"

    # if [ "$OS" == "Darwin" ]; then
    #     sym_link "$HOME/.zshrc" "$dir/.config/zsh/macos/.zshrc"
    # elif [ "$OS" == "Linux" ]; then
    #     sym_link "$HOME/.zshrc" "$dir/.config/zsh/linux/.zshrc"
    # fi
}
