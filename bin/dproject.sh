#!/bin/sh

PROJECT="$(echo 'Projects
'"$(cat ~/.local/share/projects)" |
    wmenu -i)"

if [ $PROJECT = 'Projects' ]; then
    foot nvim ~/.local/share/projects &
elif [ $PROJECT != '' ]; then
    foot --working-directory $PROJECT tmux -u new-session -A -s $PROJECT &
fi
