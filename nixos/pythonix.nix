{ config, pkgs, ... }:
let
  python3-with-my-packages =
    pkgs.python3.withPackages (python-packages: with python-packages; [
      numpy
      notebook
      jupyterlab
      pandas
      matplotlib
      scipy
      tensorflow
  ]);
in
{
  environment.systemPackages = with pkgs; [
    python3-with-my-packages
  ];
}
