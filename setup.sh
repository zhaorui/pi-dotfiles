#!/bin/bash

mkdir -p ~/Code
mkdir -p ~/Scripts


sudo apt update
sudo apt upgrade

# setup vim
sudo apt install vim
rm -rf ~/.vim_runtime
git clone --depth=1 https://github.com/zhaorui/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh

# setup zsh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
./add_zsh_plugin.py zsh-autosuggestions

