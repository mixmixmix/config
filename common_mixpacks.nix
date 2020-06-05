{ config, pkgs, ... }:
let
  R-with-my-packages = pkgs.rWrapper.override{ packages = with pkgs.rPackages; [ swirl ggplot2 dplyr xts markdown shiny shinyjs shinythemes shinyWidgets shinydashboard DT ggpubr deSolve lubridate data_table readxl tidyverse ]; };
in
{
  environment.systemPackages = with pkgs; [
    #key apps
    slack firefox networkmanager zsh thunderbird discord steam evince	libreoffice	blender tdesktop signal-desktop
    teams claws-mail
    #photo, audio, video
    feh vlc mplayer ffmpeg clipgrab audacity youtube-dl
    imagej darktable shotwell  cinelerra shotcut
    #openshot-qt #apparently broken in 20.03
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
    chrony gparted ntfs3g unrar unp zip
    #file sync
    dropbox dropbox-cli calibre
    bitwarden bitwarden-cli
    keepass kpcli
    #developes
    qt5Full
    gnome2.gtk postgresql sqlite
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
    monero monero-gui electrum
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
    zotero zoom-us
    R-with-my-packages
    texlive.combined.scheme-full
  ];
  fonts = {
    fonts = with pkgs; [
      dejavu_fonts
      source-code-pro
      source-sans-pro
      source-serif-pro
      noto-fonts
      corefonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts
      dina-font
      proggyfonts
    ];
    fontconfig = {
      penultimate.enable = false;
      defaultFonts = {
        monospace = [ "Source Code Pro" ];
        sansSerif = [ "Source Sans Pro" ];
        serif     = [ "Source Serif Pro" ];
      };
    };
  };
}
