#!/bin/bash

install_lazygit_fedora() {
    set_error_trap
    echo_inf "Installing ${GREEN}lazygit${NO_COLOR}..."

    sudo dnf install -y dnf-plugins-core
    sudo dnf copr enable atim/lazygit -y
    sudo dnf check-update -y
    sudo dnf install -y lazygit
}
