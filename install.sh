#!/bin/sh

REPO="dot"
OS=$(uname -s)
GREEN='\033[0;32m'
alias echo='echo $GREEN'

install_homebrew() {
    if test ! $(which brew); then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Updating Homebrew..."
        brew update
    fi
}

sym_link() {
    if [ -f "$1" ] && [ ! -L "$1" ] && [ ! "$(readlink "$1")" == "$2" ]; then
        mv "$1" "$1.bak"
    fi
    ln -sf "$2" "$1"
}

install_brew_packages() {
    for package in "$@"; do
        echo "Installing $package..."
        if brew info "$package" | grep -q "Cask"; then
            brew install --cask "$package"
        else
            brew install "$package"
        fi
    done
}

tap_brew() {
    for tap in "$@"; do
        echo "Tapping $tap..."
        brew tap "$tap"
    done
}

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

if [ "$1" == "simple" ]; then
    if [ "$OS" == "Darwin" ]; then
        install_homebrew

        taps=()
        tap_brew "${taps[@]}"

        packages=(git tmux vim)
        install_brew_packages "${packages[@]}"
    elif [ "$OS" == "Linux" ]; then
        echo "Linux not implemented yet"
        exit 1
    fi

    echo "Setting up symlinks..."
    sym_link "$HOME/.gitconfig" "$HOME/.dotfiles/.config/git/.gitconfig"
    sym_link "$HOME/.tmux.conf" "$HOME/.dotfiles/.config/tmux/.tmux.conf"
    sym_link "$HOME/.vimrc" "$HOME/.dotfiles/.config/vim/.vimrc"
else
    if [ "$OS" == "Darwin" ]; then
        install_homebrew

        taps=()
        tap_brew "${taps[@]}"

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
        install_brew_packages "${packages[@]}"

        # Extra
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

        echo "Setting up symlinks..."
        sym_link "$HOME/.gitconfig" "$HOME/.dotfiles/.config/git/.gitconfig"
        sym_link "$HOME/.tmux.conf" "$HOME/.dotfiles/.config/tmux/.tmux.conf"
        sym_link "$HOME/.vimrc" "$HOME/.dotfiles/.config/vim/.vimrc"
        sym_link "$HOME/.zshrc" "$HOME/.dotfiles/.config/zsh/.zshrc"
        sym_link "$HOME/.config/fish/config.fish" "$HOME/.dotfiles/.config/fish/config.fish"
        sym_link "$HOME/.config/nu/config.toml" "$HOME/.dotfiles/.config/nu/config.toml"
        sym_link "$HOME/.config/starship.toml" "$HOME/.dotfiles/.config/starship.toml"
        sym_link "$HOME/.config/omf" "$HOME/.dotfiles/.config/omf"

    elif [ "$OS" == "Linux" ]; then
        echo "Linux not implemented yet"
    fi
fi

echo "Dotfiles installed!"
exit 0
