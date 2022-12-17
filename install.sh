#!/bin/sh

# Constants
DOTFILES_REMOTE_HTTPS="https://github.com/davidandradeduarte/dot.git"
DOTFILES_REMOTE_SSH="git@github.com:davidandradeduarte/dot.git"
DOTFILES_DIR="$HOME/.dotfiles"
OS=$(uname -s)
GREEN='\033[0;32m'

# Aliases
alias echo='echo $GREEN'

# Functions
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

# Main
if [ -d "$DOTFILES_DIR" ]; then
    remote=$(git -C "$DOTFILES_DIR" remote get-url origin)
    if [ $remote == $DOTFILES_REMOTE_HTTPS ] || [ $remote == $DOTFILES_REMOTE_SSH ]; then
        echo "Updating dotfiles..."
        git -C "$DOTFILES_DIR" pull
    else
        echo -n "$DOTFILES_DIR already exists but it's not $DOTFILES_REMOTE_HTTPS nor $DOTFILES_REMOTE_SSH. Do you want to delete it and clone again? (y/n) "
        read -r answer
        if [ "$answer" == "y" ]; then
            echo "Deleting folder..."
            rm -rf "$DOTFILES_DIR"
            echo "Cloning dotfiles..."
            git clone $DOTFILES_REMOTE_HTTPS "$DOTFILES_DIR"
        fi
    fi
else
    echo "Cloning dotfiles..."
    git clone $DOTFILES_REMOTE_HTTPS "$DOTFILES_DIR"
fi

if [ "$1" == "basic" ]; then
    # Basic
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
    sym_link "$HOME/.gitconfig" "$DOTFILES_DIR/.config/git/.gitconfig"
    sym_link "$HOME/.tmux.conf" "$DOTFILES_DIR/.config/tmux/.tmux.conf"
    sym_link "$HOME/.vimrc" "$DOTFILES_DIR/.config/vim/.vimrc"
else
    # Full
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
        # TODO
        # sym_link "$HOME/.gitconfig" "$DOTFILES_DIR/.config/git/.gitconfig"
        # sym_link "$HOME/.tmux.conf" "$DOTFILES_DIR/.config/tmux/.tmux.conf"
        # sym_link "$HOME/.vimrc" "$DOTFILES_DIR/.config/vim/.vimrc"
        # sym_link "$HOME/.zshrc" "$DOTFILES_DIR/.config/zsh/.zshrc"
        # sym_link "$HOME/.config/fish/config.fish" "$DOTFILES_DIR/.config/fish/config.fish"
        # sym_link "$HOME/.config/nu/config.toml" "$DOTFILES_DIR/.config/nu/config.toml"
        # sym_link "$HOME/.config/starship.toml" "$DOTFILES_DIR/.config/starship.toml"
        # sym_link "$HOME/.config/omf" "$DOTFILES_DIR/.config/omf"

    elif [ "$OS" == "Linux" ]; then
        echo "Linux not implemented yet"
    fi
fi

echo "Dotfiles installed! :)"
exit 0
