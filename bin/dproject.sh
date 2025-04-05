#!/bin/sh

PROJECT="$(echo 'Projects
'"$(cat ~/.local/share/projects)" |
    wmenu -i)"

if [ $PROJECT = 'Projects' ]; then
    alacritty -e nvim ~/.local/share/projects &
elif [ $PROJECT != '' ]; then
    alacritty --working-directory $PROJECT -e tmux -u new-session -A -s $PROJECT &
fi
