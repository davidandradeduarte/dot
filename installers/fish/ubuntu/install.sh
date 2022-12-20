#!/bin/bash

install_fish_ubuntu() {
    set_error_trap
    echo_inf "Installing ${GREEN}fish${NO_COLOR}..."

    sudo apt-add-repository -y ppa:fish-shell/release-3
    sudo apt update -y
    sudo apt install -y fish
}
