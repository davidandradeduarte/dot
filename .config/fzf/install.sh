#!/bin/sh

install_fzf() {
    set_error_trap
    echo_inf "Installing ${GREEN}fzf${NO_COLOR}..."
    if [ -d "$HOME/.fzf" ]; then
        echo_warn "${YELLOW}$HOME/.fzf${NO_COLOR} already exists. Skipping ${YELLOW}fzf${NO_COLOR} installation."
        return
    fi
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
}
