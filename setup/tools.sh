#!/usr/bin/env bash

# TOOLS_DIR="$BASE_DIR/tools"
# SOFTWARE_DIR="$BASE_DIR/software"
# LSP_DIR="$BASE_DIR/software"
# FORMATTER_DIR="$BASE_DIR/software"

source ./config.sh
# im using an appimage from github, as apt
# does not have the latest stable nvim out
# of the box and I dont want to have to add
# the store
mkdir -p $TOOLS_INSTALL_DIR

# first and foremost my beloved NVIM
NVIM_INSTALL_PATH="$TOOLS_INSTALL_DIR/nvim"
if [ ! -f $NVIM_INSTALL_PATH ]; then
	echo "Installing nvim..."
	cd $(mktemp -d)
	pwd
	wget -q --show-progress "https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.appimage"
	cp -r nvim-linux-x86_64.appimage $NVIM_INSTALL_PATH
	echo "trying to create symlink from $NVIM_INSTALL_PATH to $TOOLS_DIR"
	chmod +x $NVIM_INSTALL_PATH
	ln -s "$NVIM_INSTALL_PATH" "$TOOLS_DIR/nvim"
	echo "Installed nvim under $NVIM_INSTALL_PATH"
else
	echo "Found existing nvim installation"
fi
