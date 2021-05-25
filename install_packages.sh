#!/bin/bash

if [[ "$EUID" = 0 ]]; then
    echo "Sudo permissions ok"
else
    echo "Sudo password: "
    sudo -k
    if sudo true; then
        echo "Sudo permissions acquired"
    else
        echo "Wrong Sudo password"
        exit 1
    fi
fi

packages=(
    neovim
    gptfdisk
    trash-cli
    zsh-theme-powerlevel10k
    zsh-autosuggestions
    man-pages
    tmux
    ccls
)

aur_packages=(
    oh-my-zsh-git
    nvimpager-git
)

packages_str=""
for pkg in ${packages[@]}; do
    packages_str="$packages_str $pkg"
done

aur_packages_str=""
for pkg in ${aur_packages[@]}; do
    aur_packages_str="$aur_packages_str $pkg"
done

sudo pacman -Sy
sudo pacman -S $packages_str
yay -S $aur_packages_str
