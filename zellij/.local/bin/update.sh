#!/usr/bin/env bash

path=$(pwd);
cd ~/private/nixos/;
sudo nix flake update;
flatpak update -y

