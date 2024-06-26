#!/bin/bash

########## ---------- Installing Paru or yay & others ---------- ##########


# Installing yay
if command -v yay >/dev/null 2>&1; then
    printf "yay is already installed\n"
else
    printf "Installing yay\n"
    {
        cd "$HOME" || exit
        git clone https://aur.archlinux.org/yay.git
        cd yay || exit
        makepkg -si --noconfirm
        } || {
        printf "\nFailed to install yay. You may need to install it manually\n"
    }
fi

# Installing tdrop for scratchpads
# if command -v tdrop >/dev/null 2>&1; then
#     printf "\nTdrop is already installed\n"
# else
#     printf "\nInstalling tdrop, this should be fast!\n"
#     yay -S tdrop-git --noconfirm
# fi

# Installing xqp
# if command -v xqp >/dev/null 2>&1; then
#     printf "\nxqp is already installed\n"
# else
#     printf "\nInstalling xqp, this should be fast!\n"
#     yay -S xqp --noconfirm
# fi

# Installing Eww
if command -v eww >/dev/null 2>&1; then
    printf "\nEww is already installed\n"
else
    printf "\nInstalling Eww, this could take 10 mins or more.\n"
    {
        sudo pacman -S rustup libdbusmenu-glib gtk-layer-shell libdbusmenu-gtk3 --noconfirm
        git clone https://github.com/elkowar/eww
        cd eww || exit
        cargo build --release --no-default-features --features x11
        sudo install -m 755 "$HOME/eww/target/release/eww" -t /usr/bin/
        cd "$HOME" || exit
        rm -rf {yay,.cargo,.rustup,eww}
        } || {
        printf "\nFailed to install Eww. You may need to install it manually\n"
    }
fi
