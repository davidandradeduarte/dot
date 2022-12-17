#!/bin/bash

# Install dotfiles
/bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/install.sh) $1

# Run default shell
$SHELL
