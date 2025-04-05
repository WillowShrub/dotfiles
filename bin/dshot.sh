#!/bin/sh

SETTING=$(printf "Selection\nWindow\nScreen" | wmenu -i)

case $SETTING in
    "Selection" )
        niri msg action screenshot
        ;;
    "Window" )
        niri msg action screenshot-window
        ;;
    "Screen" )
        niri msg action screenshot-screen
        ;;
esac
