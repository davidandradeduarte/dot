#!/bin/bash

install_chrome_fedora() {
    set_error_trap
    echo_inf "Installing ${GREEN}google-chrome${NO_COLOR} for Fedora..."

    if [[ $(uname -m) == "aarch64" ]]; then
        echo_warn "Skipping ${YELLOW}google-chrome${NO_COLOR} for Fedora on arm64..."
        echo -en "Would you like to install ${YELLOW}chromium${NO_COLOR} instead?"
        if [ "$no_prompt" == "true" ]; then
            echo ""
            echo_warn "Skipping prompt. Answering 'y'."
            answer="y"
        else
            read -p " [y/N] " answer
        fi
        if [[ $answer == "y" ]] || [[ $answer == "Y" ]]; then
            echo_inf "Installing ${GREEN}chromium${NO_COLOR}..."
            sudo dnf install -y chromium
        fi
        return
    fi

    sudo dnf install -y fedora-workstation-repositories
    sudo dnf config-manager --set-enabled google-chrome
    sudo dnf install -y google-chrome-stable
}
