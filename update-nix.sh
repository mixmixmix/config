#!/run/current-system/sw/bin/zsh

set -e
echo "You are on ${HOST}"
sudo cp common_mixpacks.nix /etc/nixos/
sudo cp pythonix.nix /etc/nixos/
sudo nixos-rebuild switch
cd nixos_${HOST}
sudo cp configuration.nix /etc/nixos/
echo "Finished!"
