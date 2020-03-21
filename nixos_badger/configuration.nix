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
  boot.loader.grub.enable = false;
  #boot.loader.grub.device = "/dev/nvme0n1";
  #boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.resumeDevice = "/dev/nvme0n1p1";
  # TODO implement better energy saving ?
  #boot.extraModulePackages = with config.boot.kernelPackages;[acpi-call tp-smapi];

  networking.hostName = "badger"; # Define your hostname.
  networking.networkmanager.enable = true;  # Enables wireless support via wpa_supplicant.
  services.chrony.enable = true;

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

  # List packages installed in system profile. To search, run: $ nix search
  # wget
  environment.systemPackages = with pkgs; [
	#(import /etc/nixos/emacs.nix)
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
	powertop
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
	colordiff	
	arp-scan
	texlive.combined.scheme-full
	#desktop
	gnome2.gtk
	#FJELLTOPP
	docker
	docker-compose
	jetbrains.pycharm-professional
	autofs5
	afuse
	geteltorito
	darktable
	fortune
	cowsay
	lolcat
	#python2
	awscli
	#life
	thunderbird
	discord
	steam
	evince
	libreoffice	
	blender
	shotwell
	tdesktop
	signal-desktop
	#
	cmatrix
	monero monero-gui
	openvpn
	#xmonad nad other geeks
	xmobar
	dmenu
	# obvious and basic like lspci
	pciutils
	chrony
	gparted
	ntfs3g
	#GPU fun
	unigine-valley
	glmark2
	mesa
	freeglut
  	#dev etc:
  	conda
        glib
	emacs
	exiftool
	R
	rstudio
	steam
	steam-run-native
	steam-run
	octaveFull
	gcc
	molly-guard
	pmutils
	vscode-with-extensions
	wmname
	#tools
	nix-index
	lightlocker
	unar
	openshot-qt
	cinelerra
	shotcut

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  hardware.nvidia.optimus_prime.enable = true;
  hardware.nvidia.optimus_prime.nvidiaBusId = "PCI:1:0:0";
  hardware.nvidia.optimus_prime.intelBusId = "PCI:0:2:0";
  hardware.opengl.enable = true;


  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver = {
  		enable = true;
  		layout = "gb";
  		xkbOptions = "caps:escape";
  		displayManager.lightdm.enable = true;
		videoDrivers = ["nvidia"];
  # Enable touchpad support.
		libinput.enable = true;
		desktopManager = {
		default = "xfce";
		xterm.enable = true;
		xfce = {
			enable = true;
			noDesktop = true;
			enableXfwm =false;
			};
		gnome3.enable = true;
		plasma5.enable = true;
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
	virtualisation.docker.enable = true;
  #
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mix = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "sudo" "networkmanager" "docker"]; # Enable ‘sudo’ for the user.
  };
  users.users.freja = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" ]; # Enable ‘sudo’ for the user.
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
      "*/1 * * * *     mix    . /etc/profile; /home/mix/repos/organutan/pushme_badger.sh >> /home/mix/repos/organutan/autopush.log"
      "*/5 * * * *      root    date >> /tmp/cron.log"
    ];
  };

  swapDevices = [
    { device = "/dev/nvme0n1p2";
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

hardware.opengl.driSupport32Bit = true;
hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
}
