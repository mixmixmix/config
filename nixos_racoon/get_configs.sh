cp /etc/nixos/configuration.nix .
cp /etc/nixos/common_mixpacks.nix .
cp /etc/nixos/pythonix.nix .
cp ~/.xmonad/xmonad.hs .
cp ~/.spacemacs spacemacs
cp ~/.xmobarrc xmobarrc
cp ~/onstart.sh onstart.sh
echo "copied configs"
git add .
git commit -m "most recent Racoon configs"
git push

