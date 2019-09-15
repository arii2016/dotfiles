#!/bin/sh

if [ -e /mnt/boot-ro/config.txt ]; then
    echo Already write protected
else
    sudo grep -v initramfs /boot/config.txt >/tmp/config.txt
    sudo echo initramfs initrd.gz >> /tmp/config.txt
    sudo cp /tmp/config.txt /boot/config.txt
    sudo reboot
fi

