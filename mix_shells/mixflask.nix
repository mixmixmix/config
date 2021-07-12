# python.nix
with (import <nixos-unstable> {config = { allowUnfree = true; };});
let
  my-python-packages = python-packages: with python-packages; [
    pandas
    flask-appbuilder
    # other python packages you want
  ];
  python-with-my-packages = python3.withPackages my-python-packages;
in
mkShell {
  buildInputs = [
    python-with-my-packages
  ];
}
