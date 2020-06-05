set -e
sudo cp common_mixpacks.nix /etc/nixos/common_mixpacks.nix
sudo nixos-rebuild switch
