#!/bin/bash

source ./basic.sh

groups | egrep -qw "root|admin|sudo" || eval 'printf "Need privileges to run\n"; exit 1'

mkdir -p ~/Code
mkdir -p ~/Scripts

sudo apt update
sudo apt upgrade

# git
setup_git

# samba
echo -n "do you want to setup samba? [Y/N]"
read YN
if [ $YN = 'y' ] || [ $YN = 'Y' ];then
    echo -n "share path [~/Public]: "
    read SHARED_PATH
    eval "SHARED_PATH=${SHARED_PATH}"
    SHARED_PATH=${SHARED_PATH:-~/Public}
    setup_smb ${SHARED_PATH}
fi

# vim
sudo apt install vim
rm -rf ~/.vim_runtime
git clone --depth=1 https://github.com/zhaorui/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh

# zsh
export ZSH=
rm -rf ~/.oh-my-zsh/
setup_dns
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
./add_zsh_plugin.py zsh-autosuggestions
reset_dns

