#!/bin/bash

setup_fish() {
    set_error_trap
    echo_inf "Setting up ${GREEN}fish${NO_COLOR}..."

    if [ ! -d "$HOME/.oh-my-fish" ]; then
        echo_inf "Installing ${GREEN}oh-my-fish${NO_COLOR}..."
        curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish -c 'source - --noninteractive --yes'
    fi

    # sym_link "$HOME/.config/fish/config.fish" "$dir/.config/fish/config.fish"
}
