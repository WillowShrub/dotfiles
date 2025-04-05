#!/bin/sh
#lsblk -pJy |
#    jq '.blockdevices |
#    map(select(.name!="/dev/nvme0n1" and .mountpoints == [null])) |
#    map(if .has("children") then
#     .children.map(select(.mountpoints == [null])).[]
#    end) | .[]'
OPTION=$(printf 'printf\nCalc\nDraw\nImpress\nBase\nGlobal\nMath\nWeb'| wmenu -i | tr '[:upper:]' '[:lower:]')

if [ $OPTION ]; then
   soffice --$OPTION
fi
