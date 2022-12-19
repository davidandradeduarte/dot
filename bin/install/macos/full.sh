#!/bin/bash

# full_macos runs the full installation script for macOS.
full_macos() {
    set_error_trap
    echo_inf "Setting up full macOS environment..."

    # Package managers
    install_homebrew

    # Taps
    taps=()
    tap_brew "${taps[@]}"

    # Packages
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

    # if [ ! -d "$HOME/.local/share/omf" ]; then
    #     echo_inf "Installing oh-my-fish..."
    #     curl -L https://get.oh-my.fish | fish
    # fi

    # if [ ! -d "$HOME/.config/nu/plugins" ]; then
    #     echo_inf "Installing oh-my-nushell..."
    #     nu --install oh-my-nu
    # fi

    # if [ ! -d "$HOME/.oh-my-posh" ]; then
    #     echo_inf "Installing oh-my-posh..."
    #     pwsh -c "Install-Module oh-my-posh -Scope CurrentUser"
    # fi
}
