#!/bin/bash

/bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/install.sh) $1

if [ $? -eq 0 ]; then
    $SHELL
fi
