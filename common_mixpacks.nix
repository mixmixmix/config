{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
#photo, audio, video
    feh
    #paintlike
    mtpaint
    mypaint
    pinta
    tuxpaint
#networking
    mtr
    bind #for package dig
#system management
    baobab #disk utility analyser
#web fun
    #chromium #it keeps appearing instead of firefox in thunderbird links. Till I can fix it, it is out.
#science
    zotero
  ];
}
