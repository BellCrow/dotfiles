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
NVIM_PATH="$TOOLS_INSTALL_DIR/nvim"
echo "$NVIM_PATH"
if [ ! -f $NVIM_PATH ]; then
	echo "Installing nvim..."
	TEMP=$(mktemp)
	echo "Temp dir is here: $TEMP"
	cd $TEMP
	pwd
	wget "https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.tar.gz"
	tar -xzf nvim-linux-x86_64.tar.gz
	cp nvim-linux-x86_64 $NVIM_PATH
	ln -s $NVIM_PATH $TOOLS_PATH/nvim
	cd -
	echo "done"
else
	echo "Found existing nvim installation"
fi
