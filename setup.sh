#!/bin/sh

stow -v -R -t ~/.config config
stow -v -R -t ~ home
stow -v -R -t ~/.local/bin bin
