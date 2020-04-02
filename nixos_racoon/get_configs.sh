cp /etc/nixos/common_mixpacks.nix ../
cp ~/.xmonad/xmonad.hs ../
cp /etc/nixos/pythonix.nix ../
cp ~/.xmobarrc ../xmobarrc
cp ~/.spacemacs ../spacemacs

cp /etc/nixos/configuration.nix .
cp ~/onstart.sh onstart.sh
echo "copied configs"
git add .
git commit -m "most recent Racoon configs"
git push

