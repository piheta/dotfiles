#!/bin/sh

ask() {
    read -p "$1 [y/n]: " yn
    case $yn in
        [Yy]* ) return 0;;  # Yes
        * ) return 1;;      # No
    esac
}

change_wallpaper() {
    osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$1\""
}

# Wallpaper selection
select_wallpaper() {
    echo "Choose a wallpaper: sand, stairs, sakura, darkpink, green, lightpink, orange, red"
    read -p "Enter your choice: " choice

    case $choice in
        sand) wallpaper="wallpapers/sand.jpg";;
        stairs) wallpaper="wallpapers/stairs.jpg";;
        sakura) wallpaper="wallpapers/sakura.jpeg";;
        darkpink) wallpaper="wallpapers/painted/darkpink.png";;
        green) wallpaper="wallpapers/painted/green.png";;
        lightpink) wallpaper="wallpapers/painted/lightpink.png";;
        orange) wallpaper="wallpapers/painted/orange.png";;
        red) wallpaper="wallpapers/painted/red.png";;
        *) echo "Invalid choice, defaulting to sand.jpg"; wallpaper="wallpapers/sand.jpg";;
    esac

    change_wallpaper "$(pwd)/$wallpaper"
}

select_wallpaper
ask "Install Homebrew?" && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ask "Install packages from the Brewfile?" && brew bundle --file Brewfile && open /Applications/Rectangle.app/

# Create symbolic links for configuration
mkdir -p ~/.config

[ ! -e ~/.config/kitty ] && ln -s "$(pwd)/kitty" ~/.config/kitty
[ ! -e ~/.config/nvim ] && ln -s "$(pwd)/nvim" ~/.config/nvim
[ ! -e ~/.config/skhd ] && ln -s "$(pwd)/skhd" ~/.config/skhd
[ ! -e ~/.zshrc ] && ln -s "$(pwd)/.zshrc" ~/.zshrc
