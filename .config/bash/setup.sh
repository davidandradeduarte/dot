#!/bin/bash

setup_bash() {
    set_error_trap
    echo_inf "Setting up ${GREEN}bash${NO_COLOR}..."

    if [ ! -d "$HOME/.oh-my-bash" ]; then
        echo_inf "Installing ${GREEN}oh-my-bash${NO_COLOR}..."
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended
    fi

    sym_link "$HOME/.bashrc" "$dir/.config/bash/.bashrc"

    # if [ "$OS" == "Darwin" ]; then
    #     sym_link "$HOME/.bashrc" "$dir/.config/bash/macos/.bashrc"
    # elif [ "$OS" == "Linux" ]; then
    #     sym_link "$HOME/.bashrc" "$dir/.config/bash/linux/.bashrc"
    # fi
}
