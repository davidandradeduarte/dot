#!/bin/bash

install_golang_ubuntu() {
    set_error_trap
    echo_inf "Installing ${GREEN}golang${NO_COLOR} for Ubuntu..."

    # if arch is arm download arm version
    if [[ "$(uname -m)" == "aarch64" ]]; then
        curl -OL https://go.dev/dl/go1.19.4.linux-arm64.tar.gz
        sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.4.linux-arm64.tar.gz
        rm go1.19.4.linux-arm64.tar.gz
    else
        curl -OL https://go.dev/dl/go1.19.4.linux-amd64.tar.gz
        sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.4.linux-amd64.tar.gz
        rm go1.19.4.linux-amd64.tar.gz
    fi

    # TODO: this needs to be added to the .bashrc provided
    # export PATH="$(go env GOPATH)/bin:$PATH"
    # find a way to make it generic across OS
    export PATH=$PATH:/usr/local/go/bin
}
