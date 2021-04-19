{ config, pkgs, ... }:
let
  R-with-my-packages = pkgs.rWrapper.override{ packages = with pkgs.rPackages; [ swirl ggplot2 dplyr xts markdown shiny shinyjs shinythemes shinyWidgets shinydashboard DT ggpubr deSolve lubridate data_table readxl tidyverse ]; };
  hsEnv = pkgs.haskellPackages.ghcWithPackages (self : [
  self.ghc
  self.csv
  self.aeson
  self.hxt
  self.split
  self.HandsomeSoup
  ]);
  unstable = import <nixos-unstable> {config = { allowUnfree = true; };};
in
{
  environment.systemPackages = with pkgs; [
    #key apps
    slack firefox networkmanager zsh discord evince	libreoffice	tdesktop signal-desktop
    mailspring thunderbird
    touchegg
    teams
    #photo, audio, video
    feh vlc mplayer ffmpeg-full clipgrab audacity youtube-dl
    imagej darktable shotwell  cinelerra shotcut jbidwatcher
    mullvad-vpn pinentry softether kazam 
    busybox spotify spotifyd
    #openshot-qt #apparently broken in 20.03
    #paintlike
    mtpaint mypaint pinta tuxpaint
    #linux basic
    xterm xclip tmux git htop ytop vim wget ranger powertop pmutils
    oh-my-zsh usbutils mc irssi sl exfat-utils 	archiver 	bzip2 unzip 	chrony pmutils 	geteltorito 	colordiff 	arp-scan direnv
    fortune cowsay lolcat autofs5 afuse file
    pciutils ncat#lspci
    chrony gparted ntfs3g unrar unp zip
    gnumake
    #file sync
    #dropbox dropbox-cli
    qbittorrent
    calibre
    bitwarden bitwarden-cli
    keepass kpcli rclone gnome3.simple-scan
    #developes
    # qt5Full #broken in 20.09?
    xfce.xfce4-pulseaudio-plugin
    gnome2.gtk postgresql sqlite
    postgresql11Packages.postgis pgloader
    dbeaver
    pgadmin pgmodeler qgis gdal pgmanage
    mysql-workbench dbeaver
    gtk2-x11
    pkg-config
    ispell
    #haskell
    hsEnv
    #FJELLTOPP
    docker
    docker-compose
    jetbrains.pycharm-professional
    awscli #python2
    #dev etc:
    conda glib emacs exiftool rstudio octaveFull gcc molly-guard pmutils vscode-with-extensions wmname nix-index unar
    opencv
    #networking
    mtr fish tlp nox
    bind #for package dig
    #system management
    baobab #disk utility analyser
    #geeky:
    vulkan-tools
    cmatrix
    monero monero-gui electrum
    openvpn
    transmission-gtk
    #xmonad nad other geeks
    xmobar
    dmenu
    #GPU fun
    unigine-valley
    glmark2
    mesa
    zoom-us
    freeglut
    #Games
    openttd openra
    zerotierone
    #web fun
    chromium #it keeps appearing instead of firefox in thunderbird links. Till I can fix it, it is out.
    #science
    zotero
    R-with-my-packages
    texlive.combined.scheme-full
    haskellPackages.csv
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
      defaultFonts = {
        monospace = [ "Source Code Pro" ];
        sansSerif = [ "Source Sans Pro" ];
        serif     = [ "Source Serif Pro" ];
      };
    };
  };
       nixpkgs.config.permittedInsecurePackages = [
         "openssl-1.0.2u"
       ];


  services.mysql = {
    enable = true;
    package = pkgs.mysql;
    bind = "localhost";
    # ensureDatabases = [
    #   miksuser.maindb
    # ];
    # ensureUsers = [
    #   {
    #     name = "miksuser";
    #     ensurePermissions = {
    #       "*.*" = "ALL PRIVILEGES";
    #     };
    #   }
    # ];
  # };


  };
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_11;
    extraPlugins = [pkgs.postgis];
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 11 ''
      local all all trust
      host all all ::1/128 trust
      host all all 127.0.0.1/32 trust
    '';
    };


}
