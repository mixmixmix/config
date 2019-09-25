{ config, pkgs, ... }:

environment.systemPackages = 

let
  myEmacs = pkgs.emacs;
  emacsWithPackages = (pkgs.emacsPackagesNgGen myEmacs).emacsWithPackages;
in
[
  (emacsWithPackages (epkgs:(with epkgs.melpaPackages;  [
	evil
	magit
  ]) ++ (with epkgs.elpaPackages; [
	spinner
])
)
)
];

