# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./pythonix.nix
#      ./spacemacs.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  boot.resumeDevice = "/dev/sda2";
  # TODO implement better energy saving ?
  #boot.extraModulePackages = with config.boot.kernelPackages;[acpi-call tp-smapi];
  boot.initrd.kernelModules = ["acpi" "thinkpad-acpi" "acpi-call" "tp-smapi"];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call tp_smapi];

  networking.hostName = "raccoon"; # Define your hostname.
  networking.networkmanager.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  services.redshift = {
    enable = true;
    temperature.night = 4000;
  };
  location.latitude = 55.8536;
  location.longitude = -4.2786;



  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	#(import /etc/nixos/emacs.nix)
	redshift
	oh-my-zsh
	dropbox dropbox-cli
	bitwarden-cli
	bitwarden
	keepass kpcli
	qt5Full	
	slack feh imagej
    wget vim mc htop tmux git 
	firefox python3
	networkmanager
	xterm zsh
	usbutils
	ranger 
	wget xclip
	vlc	mplayer
	ffmpeg	ghc
	clipgrab irssi
	bitwarden-cli audacity
	sl youtube-dl
	fish tlp nox
	tpacpi-bat
	exfat-utils
	gnupg archiver
	bzip2 unzip
	chrony pmutils
	geteltorito
	arp-scan
	cmatrix
	monero monero-gui
	openvpn
	dmenu
	xmobar	
	colordiff
	pciutils
	evince
	thunderbird
	libreoffice
	blender
	shotwell
	conda
	jetbrains.pycharm-professional
	#util
	autofs5 #automount kernel
	afuse #automount user space
	geteltorito
	powertop
	upower
	#FUN FUN FUN
	darktable
	fortune
	cowsay
	lolcat
	R
	rstudio
	#comms
	tdesktop
	signal-desktop
	octaveFull
	gcc
	steam
	steam-run-native
	steam-run
	molly-guard	#Attempts to prevent you from accidentally shutting down or rebooting machines
	pmutils
	vscode-with-extensions
	wmname
#	lightlocker
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.tlp.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # DNS issue in firefox: https://github.com/NixOS/nixpkgs/issues/63754
  networking.resolvconf.dnsExtensionMechanism = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  #disable bluetooth
  hardware.bluetooth.enable = false;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver = {
  		enable = true;
  		layout = "gb";
  		xkbOptions = "caps:escape";
  		displayManager.lightdm.enable = true;

  # Enable touchpad support.
		libinput.enable = true;
		desktopManager = {
			default = "xfce";
			xterm.enable = false;
			xfce = {
				enable = true;
				noDesktop = true;
				enableXfwm = false;
			};
		};

  windowManager = {
	default = "xmonad";
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

programs.zsh.enable = true;
  #
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mix = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "sudo" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/10 * * * *      root    . /etc/profile; bash /root/read_batt.sh"
      "*/10 * * * *      mix    . /etc/profile; bash /home/mix/repos/organutan/pushme.sh >> /home/mix/repos/organutan/autopush.log"
    ];
  };

  swapDevices = [
    { device = "/dev/sda2";
    }
  ];

services.nixosManual.showManual = true;
nixpkgs.config.allowUnfree = true; 

  fonts = {
    fonts = with pkgs; [
      dejavu_fonts
      source-code-pro
      source-sans-pro
      source-serif-pro
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

programs.zsh.interactiveShellInit = ''
  export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/

  # Customize your oh-my-zsh options here
  ZSH_THEME="bureau"
  SAVEHIST=10000
  HISTSIZE=10000
  plugins=(git vi-mode)

  source $ZSH/oh-my-zsh.sh
  alias euclid35="ssh -X 2412135k@euclid-35.maths.gla.ac.uk"
  alias dragon="~/repos/config/dragon.sh"
'';

programs.zsh.promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh

}
