#!/bin/bash

setup_fzf() {
    set_error_trap
    echo_inf "Setting up fzf..."
    yes | $HOME/.fzf/install
}
