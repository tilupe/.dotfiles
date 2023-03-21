#!/bin/sh
PWD=$(pwd)

sudo apt install libu2f-udev

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&
sudo dpkg -i $PWD/google-chrome-stable_current_amd64.deb
rm $PWD/google-chrome-stable_current_amd64.deb

