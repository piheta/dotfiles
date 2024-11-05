# #!/bin/sh

ask() {
    read -p "$1 [y/n]: " yn
    case $yn in
        [Yy]* ) return 0;;  # Yes
        * ) return 1;;      # No
    esac
}

ask "Install Homebrew?" && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ask "Install packages from the Brewfile?" && brew bundle --file Brewfile

mkdir -p ~/.config

[ ! -e ~/.config/kitty ] && ln -s "$(pwd)/kitty" ~/.config/kitty
[ ! -e ~/.config/nvim ] && ln -s "$(pwd)/nvim" ~/.config/nvim
[ ! -e ~/.config/lf ] && ln -s "$(pwd)/lf" ~/.config/lf
[ ! -e ~/.config/skhd ] && ln -s "$(pwd)/skhd" ~/.config/skhd
#[ ! -e ~/.zshrc ] && ln -s "$(pwd)/.zshrc" ~/.zshrc
