#!/bin/bash

#PWD=$(pwd)
#wget -c "https://vault.bitwarden.com/download/?app=desktop&platform=linux" -O bitwarden
#sudo chmod u+x $PWD/bitwarden
#sudo mv $PWD/bitwarden /usr/bin/
#
#echo "Downloading bitwarden icon"
#
#mkdir -p ~/Pictures/icons


wget -c "https://www.svgrepo.com/download/349309/bitwarden.svg"

mv $PWD/bitwarden.svg ~/Pictures/icons
touch ~/.local/share/applications/bitwarden.desktop

cat > ~/.local/share/applications/bitwarden.desktop <<EOM
[Desktop Entry]
Name=Bitwarden
Exec=/usr/bin/bitwarden
Icon=~/Pictures/icons/bitwarden.svg
Terminal=false
Type=Application
EOM
