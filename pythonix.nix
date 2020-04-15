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
      pip
      filterpy
  ]);
  python2-with-my-packages =
    pkgs.python2.withPackages (python-packages: with python-packages; [
      numpy
      pip
      passlib
  ]);
in
{
  environment.systemPackages = with pkgs; [
    python3-with-my-packages
    python2-with-my-packages
  ];
}
