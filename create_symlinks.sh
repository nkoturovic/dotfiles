#!/bin/bash

bup_folder=$HOME/backup-dotfiles
dot_folder=$HOME/dotfiles

dotfiles=(
    .bash_profile 
    .bashrc
    .commonrc
    .gitconfig
    .p10k.zsh
    .profile
    .Xdefaults
    .zsh_profile
    .zshrc
    .vimrc
)

dotfolders=(
    bin
    .vim
    .config/nvim
)

mkdir $bup_folder

for df in ${dotfiles[@]}; do
    mv $HOME/$df $bup_folder/$df
    ln -s $dot_folder/$df $HOME/$df
done
