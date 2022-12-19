#!/bin/bash

setup_fzf() {
    set_error_trap
    echo_inf "Setting up ${GREEN}fzf${NO_COLOR}..."
    yes | $HOME/.fzf/install
}
