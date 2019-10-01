cp /etc/nixos/configuration.nix .
cp ~/.xmonad/xmonad.hs .
cp ~/.xmobarrc .
echo "copied configs"
git add .
git commit -m "most recent Badgers configs"
git push

