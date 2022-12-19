#!/bin/bash

setup_bash() {
    echo "Setting up bash..."

    if [ ! -d "$HOME/.oh-my-bash" ]; then
        echo "Installing oh-my-bash..."
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended
    fi

    if [ "$OS" == "Darwin" ]; then
        sym_link "$HOME/.bashrc" "$dir/.config/bash/macos/.bashrc"
    elif [ "$OS" == "Linux" ]; then
        sym_link "$HOME/.bashrc" "$dir/.config/bash/linux/.bashrc"
    fi

    # replace every find in $HOME/.bashrc for $user_replace with $user
    # sed -i "s/$user/$user/g" "$HOME/.bashrc"
}
