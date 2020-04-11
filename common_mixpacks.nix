{ config, pkgs, ... }:
let
  R-with-my-packages = pkgs.rWrapper.override{ packages = with pkgs.rPackages; [ ggplot2 dplyr xts markdown shiny]; };
  in
{
  environment.systemPackages = with pkgs; [
    #key apps
    slack firefox networkmanager zsh thunderbird discord steam evince	libreoffice	blender tdesktop signal-desktop
#photo, audio, video
    feh vlc mplayer ffmpeg clipgrab audacity youtube-dl
    imagej darktable shotwell openshot-qt cinelerra shotcut
    #paintlike
    mtpaint
    mypaint
    pinta
    tuxpaint
    #linux basic
    xterm xclip tmux git htop vim wget ranger powertop
    oh-my-zsh usbutils mc irssi sl exfat-utils 	gnupg archiver 	bzip2 unzip 	chrony pmutils 	geteltorito 	colordiff 	arp-scan
    fortune cowsay lolcat autofs5 afuse
	  pciutils #lspci
    chrony gparted ntfs3g
    #file sync
    dropbox dropbox-cli
    bitwarden bitwarden-cli
    keepass kpcli
#developes
    qt5Full
    gnome2.gtk
    #haskell
    ghc
    #FJELLTOPP
    docker
    docker-compose
    jetbrains.pycharm-professional
    awscli #python2
  	#dev etc:
    conda glib emacs exiftool rstudio steam steam-run-native steam-run octaveFull gcc molly-guard pmutils vscode-with-extensions wmname nix-index unar
    #networking
    mtr fish tlp nox
    bind #for package dig
#system management
    baobab #disk utility analyser
    #geeky:
    cmatrix
    monero monero-gui
    openvpn
    #xmonad nad other geeks
    xmobar
    dmenu
    #GPU fun
    unigine-valley
    glmark2
    mesa
    freeglut
#web fun
    #chromium #it keeps appearing instead of firefox in thunderbird links. Till I can fix it, it is out.
#science
    zotero
    R-with-my-packages
    texlive.combined.scheme-full
  ];
}
