cp /etc/nixos/configuration.nix .
cp ~/.xmonad/xmonad.hs .
cp ~/.xmobarrc xmobarrc
echo "copied configs"
git add .
git commit -m "most recent Racoon configs"
git push

