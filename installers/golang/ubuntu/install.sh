#!/bin/bash

install_golang_ubuntu() {
    set_error_trap
    echo_inf "Installing ${GREEN}golang${NO_COLOR} for Ubuntu..."

    if [[ "$(uname -m)" == "aarch64" ]]; then
        curl -OL https://go.dev/dl/go1.19.4.linux-arm64.tar.gz
        sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.4.linux-arm64.tar.gz
        rm go1.19.4.linux-arm64.tar.gz
    else
        curl -OL https://go.dev/dl/go1.19.4.linux-amd64.tar.gz
        sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.4.linux-amd64.tar.gz
        rm go1.19.4.linux-amd64.tar.gz
    fi
}
