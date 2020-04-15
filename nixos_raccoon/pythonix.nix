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
      scikitlearn
      scikitimage
      tensorflow
      seaborn
      shapely
      folium
      statsmodels
      yapf
      xlrd
      pyproj #map projections
      python-dotenv
      opencv4
  ]);
in
{
  environment.systemPackages = with pkgs; [
    python3-with-my-packages
  ];
}
