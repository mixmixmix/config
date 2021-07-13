# add old nixos channel: sudo nix-channel --add https://nixos.org/channels/nixos-20.09 nixos-old
#sudo nix-channel --update
with (import <nixos-old> {});
let
  my-python-packages = python-packages: with python-packages; [
    pandas
    flask-appbuilder
    email_validator
    xlrd
    psycopg2
  ];
  python-with-my-packages = python3.withPackages my-python-packages;
in
mkShell {
  buildInputs = [
    python-with-my-packages
  ];
}
