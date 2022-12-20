#!/bin/bash

install_chrome_ubuntu() {
    set_error_trap
    echo_inf "Installing ${GREEN}google-chrome${NO_COLOR}..."

    if [[ $(uname -m) == "aarch64" ]]; then
        echo_warn "Skipping ${YELLOW}google-chrome${NO_COLOR} on arm64..."
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
            sudo apt install -y chromium-browser
        fi
        return
    fi

    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /tmp
    sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb
}
