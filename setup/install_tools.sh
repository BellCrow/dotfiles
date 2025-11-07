#!/usr/bin/env bash
# with the friendly help of MR. GPT created
set -euo pipefail

# --- Install package managers ---
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# --- Update PATH immediately ---
if ! grep -q "brew shellenv" ~/.my_zshrc; then
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.my_zshrc
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi



# --- Install tools with brew or apt ---
sudo apt update

sudo apt install -y fd-find 
sudo apt install -y python3
sudo apt install -y nodejs
sudo apt install -y stow
sudo apt install -y jq

brew install ripgrep 
brew install kubectl
brew install k9s
brew install helm
brew install lazygit
brew install neovim
brew install lazydocker
brew install uv


curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
sudo apt update
sudo apt install -y wezterm


# install dotnet
curl -sL https://dot.net/v1/dotnet-install.sh | bash

# lsp, formatters
brew install stylua
sudo apt install libxml2-utils # xml formatter
