#!/bin/bash

echo "**** Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &


# Install script for my dotfiles, should be called from .dotfiles directory 

# Create symlinks for zshrc and gitconfig
# ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
# ln -s ~/.dotfiles/.zshrc ~/.zshrc
echo "**** Symlinking config files ****"
realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

mv ~/.zshrc ~/.zshrc.old
mv ~/.gitconfig ~/.gitconfig.old
ln -s $(realpath .zshrc) ~/.zshrc
ln -s $(realpath .gitconfig) ~/.gitconfig


#
# Install fzf
#
echo "**** Installing fzf ****"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --update-rc


# Install ZSH Autosuggestions
echo "**** Installing zsh autosuggestions ****"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

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
