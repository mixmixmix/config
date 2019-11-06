cp /etc/nixos/configuration.nix .
cp /etc/nixos/python.nix .
cp /etc/nixos/emacs.nix .
cp /etc/nixos/pythonix.nix .
cp ~/.xmonad/xmonad.hs .
cp ~/.xmobarrc .
echo "copied configs"
git add .
git commit -m "most recent Badgers configs"
git push

