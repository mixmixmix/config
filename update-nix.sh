#!/run/current-system/sw/bin/zsh

set -e
echo "You are on ${HOST}"
sudo cp common_mixpacks.nix /etc/nixos/
sudo cp common_configuration.nix /etc/nixos/
sudo cp pythonix.nix /etc/nixos/
cp ~/.spacemacs ~/spacemacs.old
cp ~/.spacemacs autobup/spacemacs.old
cp ~/.ssh/config ~/.ssh/sshconf.old
cp ~/.ssh/config autobup/sshconf.old
cp appconfigs/sshconf ~/.ssh/config
cp appconfigs/tmux.conf ~/.tmux.conf
cp appconfigs/spacemacs ~/.spacemacs
cp -R appconfigs/ranger ~/.config/
cp appconfigs/xmonad.hs ~/.xmonad/xmonad.hs
xmonad --recompile
cd nixos_${HOST}
sudo cp configuration.nix /etc/nixos/
echo "Configuration files copied!"
sudo nixos-rebuild switch --show-trace
echo "Finished!"
