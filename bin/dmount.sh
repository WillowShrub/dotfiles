#/bin/sh
#lsblk -pJy |
#    jq '.blockdevices |
#    map(select(.name!="/dev/nvme0n1" and .mountpoints == [null])) |
#    map(if .has("children") then
#     .children.map(select(.mountpoints == [null])).[]
#    end) | .[]'
DISK=$(lsblk -pJy |
     jq -r '.blockdevices |
     map(select(.name != "/dev/nvme0n1" and .mountpoints == [])) |
     map(if .children then .children[] end) |
     map(select(.mountpoints == []))[].name' |
     wmenu)

if [ $DISK ]; then
    udisksctl mount -b $DISK
fi
