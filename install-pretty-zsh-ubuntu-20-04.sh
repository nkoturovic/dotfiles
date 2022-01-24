#!/bin/bash
TIMESTAMP=$(date "+%Y-%m-%d-%T")

function backup_file {
    if [ -f "$1" ] || [ -d "$1" ] ; then
        mv "$1" "$1-$TIMESTAMP.bup"
        echo "moving $1 to $1-$TIMESTAMP.bup"
    fi
}

backup_file ~/.zshrc
backup_file ~/powerlevel10k
backup_file ~/.oh-my-zsh
backup_file ~/.zsh

# Update package cache
sudo apt-get update

# Install ZSH
sudo apt-get -y install zsh

# Install dependencies
sudo apt -y install curl wget git

# Make 
mkdir $HOME/fancy-zsh-installer
cd $HOME/fancy-zsh-installer

# Install Oh-My-Zsh
# https://www.tecmint.com/install-oh-my-zsh-in-ubuntu/
CHSH="no" RUNZSH="no" sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install autosuggrestions: 
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
touch ~/.zshrc
sed -i 's/plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions)/' $HOME/.zshrc

# Download and install MesloLGS font:
# https://github.com/romkatv/powerlevel10k-media/
curl -fsSL https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o"MesloLGS NF Regular.ttf" 
curl -fsSL https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -o "MesloLGS NF Bold.ttf" 
curl -fsSL https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -o "MesloLGS NF Italic.ttf"
curl -fsSL https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -o "MesloLGS NF Bold Italic.ttf"

mkdir $HOME/.fonts
cp *.ttf $HOME/.fonts
fc-cache -f -v

# Install PowerLevel10k theme:
# https://github.com/romkatv/powerlevel10k#oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# Set ZSH_THEME to powerlevel10k
echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> $HOME/.zshrc
curl -fsSl https://raw.githubusercontent.com/nkoturovic/dotfiles/master/.p10k.zsh -o $HOME/.p10k.zsh

chmod +rx ~/.p10k.zsh
echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> ~/.zshrc
