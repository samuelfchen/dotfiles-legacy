#!/bin/bash

# Install script for my dotfiles, should be called from .dotfiles directory 

echo "**** Symlinking config files ****"
realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

echo "**** Installing oh-my-zsh"
rm -rf ~/.oh-my-zsh.old && mv ~/.oh-my-zsh ~/.oh-my-zsh.old
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc &

mv ~/.zshrc ~/.zshrc.old
mv ~/.gitconfig ~/.gitconfig.old
ln -s $(realpath .zshrc) ~/.zshrc
ln -s $(realpath .gitconfig) ~/.gitconfig

sleep 3

echo "**** Installing fzf ****"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --update-rc


# Install ZSH Autosuggestions
echo "**** Installing zsh autosuggestions ****"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install zsh-vi
git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode

# -------------

# Prompt for git email (work / personal)
echo ">>>> Override Git name? (enter name, empty for no)" 
read name
[[ ! -z "$name" ]] && echo "Overriding Git name..." && git config --global user.name "$name";
echo ">>>> Override Git email? (enter email, empty for no)" 
read email
[[ ! -z "$email" ]] && echo "Overriding Git email..." && git config --global user.email "$email";

# -------------

# Source .zshrc
echo "**** Sourcing zshrc ****"
zsh
source ~/.zshrc
