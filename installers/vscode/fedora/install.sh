#!/bin/bash

install_vscode_fedora() {
    set_error_trap
    echo_inf "Installing ${GREEN}vscode${NO_COLOR}..."

    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

    dnf check-update -y
    sudo dnf install -y code-insiders
}
