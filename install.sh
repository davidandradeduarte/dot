#!/bin/sh

REPO="dot"

if [ -d "$HOME/.dotfiles" ]; then
    dotfiles_remote=$(git -C "$HOME/.dotfiles" remote get-url origin)
    if [ $dotfiles_remote == "https://github.com/davidandradeduarte/$REPO.git" ] ||
        [ $dotfiles_remote == "git@github.com:davidandradeduarte/$REPO.git" ]; then
        echo "Updating dotfiles..."
        git -C "$HOME/.dotfiles" pull
    else
        echo "$HOME/.dotfiles already exists but it's not davidandradeduarte/$REPO. Do you want to delete it and clone again? (y/n)"
        read -r answer
        if [ "$answer" == "y" ]; then
            echo "Deleting folder..."
            rm -rf "$HOME/.dotfiles"
            echo "Cloning dotfiles..."
            git clone https://github.com/davidandradeduarte/$REPO.git "$HOME/.dotfiles"
        fi
    fi
else
    echo "Cloning dotfiles..."
    git clone https://github.com/davidandradeduarte/$REPO.git "$HOME/.dotfiles"
fi

OS=$(uname -s)

if [ "$1" == "simple" ]; then
    if [ "$OS" == "Darwin" ]; then
        if test ! $(which brew); then
            echo "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi

        taps=()

        for tap in "${taps[@]}"; do
            echo "Tapping $tap..."
            brew tap "$tap"
        done

        packages=(
            git tmux vim
        )

        for package in "${packages[@]}"; do
            echo "Installing $package..."
            if brew info "$package" | grep -q "Cask"; then
                brew install --cask "$package"
            else
                brew install "$package"
            fi
        done
    elif [ "$OS" == "Linux" ]; then
        echo "Linux not implemented yet"
        exit 1
    fi

    echo "Setting up symlinks..."
    if [ -f "$HOME/.gitconfig" ]; then
        mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak"
    fi
    if [ -f "$HOME/.tmux.conf" ]; then
        mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak"
    fi
    if [ -f "$HOME/.vimrc" ]; then
        mv "$HOME/.vimrc" "$HOME/.vimrc.bak"
    fi
    ln -sf "$HOME/.dotfiles/.config/git/.gitconfig" "$HOME/.gitconfig"
    ln -sf "$HOME/.dotfiles/.config/tmux/.tmux.conf" "$HOME/.tmux.conf"
    ln -sf "$HOME/.dotfiles/.config/vim/.vimrc" "$HOME/.vimrc"
fi

if [ "$OS" == "Darwin" ]; then
    if test ! $(which brew); then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    taps=()

    for tap in "${taps[@]}"; do
        echo "Tapping $tap..."
        brew tap "$tap"
    done

    packages=(
        # Essentials
        git tmux wget curl
        # Shells
        bash zsh fish nushell powershell
        # Prompts
        starship oh-my-posh
        # Terminal Emulators
        iterm2 alacritty kitty
        # Editors
        vim neovim nano visual-studio-code rider intellij-idea
        # Browsers
        google-chrome firefox brave-browser
        # Messaging
        slack microsoft-teams discord spotify zoom
        # Languages
        go rustup-init dotnet-sdk lua
        # CLI Tools
        kubectl kubectx k9s helm terraform terragrunt azure-cli bat exa fd fzf ripgrep htop ncdu tree jq lazygit
        # Dev
        docker
        # Misc
        openvpn-connect cloudflare-warp rectangle maccy meetingbar balenaetcher caffeine bitwarden
    )

    for package in "${packages[@]}"; do
        echo "Installing $package..."
        if brew info "$package" | grep -q "Cask"; then
            brew install --cask "$package"
        else
            brew install "$package"
        fi
    done

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    if [ ! -d "$HOME/.local/share/omf" ]; then
        echo "Installing oh-my-fish..."
        curl -L https://get.oh-my.fish | fish
    fi

    if [ ! -d "$HOME/.config/nu/plugins" ]; then
        echo "Installing oh-my-nushell..."
        nu --install oh-my-nu
    fi

    if [ ! -d "$HOME/.oh-my-posh" ]; then
        echo "Installing oh-my-posh..."
        pwsh -c "Install-Module oh-my-posh -Scope CurrentUser"
    fi
elif [ "$OS" == "Linux" ]; then
    echo "Linux not implemented yet"
fi

echo "Dotfiles installed!"
exit 0
