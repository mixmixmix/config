#!/bin/bash
set -e
cd nixos_${HOST}
zsh get_configs.sh
cd ..
git pull
sudo cp common_mixpacks.nix /etc/nixos/
sudo cp pythonix.nix /etc/nixos/

echo "Finished!"
