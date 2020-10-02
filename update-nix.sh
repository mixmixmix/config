#!/run/current-system/sw/bin/zsh

set -e
echo "You are on ${HOST}"
sudo cp common_mixpacks.nix /etc/nixos/
sudo cp common_configuration.nix /etc/nixos/
sudo cp pythonix.nix /etc/nixos/
cd nixos_${HOST}
sudo cp configuration.nix /etc/nixos/
echo "Configuration files copied!"
sudo nixos-rebuild switch --show-trace
echo "Finished!"
