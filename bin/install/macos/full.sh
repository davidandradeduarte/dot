#!/bin/bash

full_macos() {
    echo "Setting up full macOS environment..."

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

    # TODO: this can be moved to .config folders inside setup.sh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    if [ ! -d "$HOME/.oh-my-bash" ]; then
        echo "Installing oh-my-bash..."
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
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
}
