{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
#photo, audio, video
    feh
#networking
    mtr
    bind #for package dig
#system mangement
    baobab #disk utility analyser
#web fun
    chromium
  ];
}
