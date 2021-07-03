{ config, pkgs, ... }:
{
programs.gnupg.agent = {
  enable = true;
  enableSSHSupport = true;
  pinentryFlavor = "curses";
};

programs.zsh.enable = true;
  #
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mix = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "sudo" "networkmanager" "docker"]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "21.05"; # Did you read the comment?

  # DNS issue in firefox: https://github.com/NixOS/nixpkgs/issues/63754
  networking.resolvconf.dnsExtensionMechanism = false;
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 5321 17500 ];
    allowedUDPPorts = [ 17500 ];
  };

  # Select internationalisation properties.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };
    i18n.defaultLocale = "en_GB.UTF-8";

  services.mullvad-vpn.enable = true;
  # Set your time zone.
  # time.timeZone = "Europe/Warsaw";
  #time.timeZone = "Europe/London";

  #disable bluetooth. doens't work. I still need to sudo rfkill block bluetooth
  hardware.bluetooth.enable = false;
  boot.blacklistedKernelModules = ["bluetooth" "btusb"];
  #also need to disable ethernet manually sudo modprobe -r e1000e  
  #ATM ethernet is disabled in ThinkVantage in BIOS

  services.upower.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver = {
  		enable = true;
  		layout = "gb";
  		xkbOptions = "caps:escape, ctrl:swap_lalt_lctl, ctrl:swap_ralt_rctl";
  		displayManager.lightdm.enable = true;
      #videoDrivers = ["nvidia"];
      displayManager.defaultSession = "xfce+xmonad";
      #Enable touchpad support.
		  libinput.enable = true;
		  desktopManager = {
	  	xterm.enable = true;
		  xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
			};
		gnome.enable = true;
		plasma5.enable = false; # for now due to https://github.com/NixOS/nixpkgs/issues/75867, error: The option `programs.ssh.askPassword' has conflicting definitions, in `/nix/var/nix/profiles/per-user/root/channels/nixos/nixos/modules/services/x11/desktop-managers/plasma5.nix' and `/nix/var/nix/profiles/per-user/root/channels/nixos/nixos/modules/programs/seahorse.nix'.

		};

  windowManager = {
	xmonad = { 
		enable = true;
		enableContribAndExtras = true;
	#	borderWidth = 3; TODO!
		extraPackages = haskellPackages : [
			haskellPackages.xmonad-contrib
			haskellPackages.xmonad-extras
			haskellPackages.xmonad-wallpaper
			haskellPackages.xmonad
            		haskellPackages.ghc
            		haskellPackages.xmobar
            		haskellPackages.xmonad
		];
  		};
	};
 };

nixpkgs.config.allowUnfree = true;


programs.zsh.interactiveShellInit = ''
  export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/

  # Customize your oh-my-zsh options here
  ZSH_THEME="bureau"
  SAVEHIST=10000
  HISTSIZE=10000
  EDITOR=vim #this is for ranger or others
  VISUAL=vim
  plugins=(git vi-mode)

  source $ZSH/oh-my-zsh.sh
  alias dragon="~/repos/config/dragon.sh"
  alias discord="discord"
  alias discord="Discord"
  #use SSH config instead of aliases
  #alias euclid35="ssh -X 2412135k@euclid-35.maths.gla.ac.uk"
  #alias weasel="ssh mix@217.169.28.186 -p 303"
  #alias platypus="ssh mix@217.169.28.186 -p 2244"
  alias tmux="tmux attach"
'';

programs.zsh.promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh
hardware.opengl.driSupport32Bit = true;

services.gnome.gnome-keyring.enable = true;
networking.extraHosts =
''
  127.0.0.1 localhost
  #my obsesions:
  0.0.0.0 www.theguardian.co.uk
  0.0.0.0 theguardian.co.uk
  0.0.0.0 www.theguardian.com
  0.0.0.0 theguardian.com
  0.0.0.0 cnn.com
  0.0.0.0 foxnews.com
  0.0.0.0 www.foxnews.com
  0.0.0.0 www.bbc.com
  0.0.0.0 www.bbc.co.uk
  0.0.0.0 bbc.co.uk
  0.0.0.0 slashdot.org
  0.0.0.0 www.slashdot.org
  0.0.0.0 9to5mac.com
  0.0.0.0 www.9to5mac.com
  0.0.0.0 www.onet.pl
  0.0.0.0 onet.pl
  0.0.0.0 www.travellingtabby.com
  0.0.0.0 travellingtabby.com
  0.0.0.0 www.telegraph.co.uk
  0.0.0.0 telegraph.co.uk
'';


}
