{ config, pkgs, ... }:
let python =
    let
    packageOverrides = self:
    super: {
      opencv4 = super.opencv4.overrideAttrs (old: rec {
        enableGtk2 = pkgs.gtk2;
        enableGtk3 = pkgs.gtk3;
        enableVtk = pkgs.vtk;
        enableFfmpeg = pkgs.ffmpeg-full;
        # enableGtk3 = pkgs.gtk3;
        # doCheck = true;
        });
    };
    in
      pkgs.python3.override {inherit packageOverrides; self = python;};
in
{
environment.systemPackages = with pkgs; [
  (python.withPackages(ps: with ps; [
    opencv4
    numpy
    notebook
    jupyterlab
    pandas
    matplotlib
    scipy
    scikitlearn
    scikitimage
    #tensorflow
    flask
    bokeh
    seaborn
    shapely
    folium
    statsmodels
    yapf
    xlrd
    pyproj #map projections
    python-dotenv
  ]))
];
}
