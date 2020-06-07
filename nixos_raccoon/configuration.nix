# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./pythonix.nix
      ./common_mixpacks.nix
#      ./spacemacs.nix
    ];
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  #powerManagement.cpuFreqGovernor = null; # will be managed by tlp
  #https://gist.github.com/fikovnik/f9d5283689d663d162d79c061774f79b
  #https://bbs.archlinux.org/viewtopic.php?pid=1030190#p1030190
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelParams = [
    "pcie.aspm=force"
    "i915.enable_fbc=1"
    "i915.enable_rc6=7"
    "i915.lvds_downclock=1"
    "i915.enable_guc_loading=1"
    "i915.enable_guc_submission=1"
    "i915.enable_psr=0"
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
  boot.initrd.kernelModules = ["acpi" "thinkpad-acpi" "acpi-call" "tp-smapi" "cpufreq_stats"];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call tp_smapi];

  networking.hostName = "raccoon"; # Define your hostname.
  networking.networkmanager.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };
    i18n.defaultLocale = "en_GB.UTF-8";

  # Set your time zone.
 # time.timeZone = "Asia/Kolkata";
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
	slack
  slack-term
  slack-cli
  imagej
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
  ispell
	chrony pmutils
	geteltorito
	arp-scan
  powertop
  thinkfan
  lm_sensors
	cmatrix
	monero monero-gui
	openvpn
	dmenu
	xmobar
  toggldesktop
	colordiff
	pciutils
	evince
	thunderbird
  gnome3.evolution
  discord
	libreoffice
	blender
	conda
	jetbrains.pycharm-professional
  virtualbox
	#util
	autofs5 #automount kernel
	afuse #automount user space
	geteltorito
	upower
	#FUN FUN FUN
  #games
  openra

  #photo
	darktable
  ufraw
	shotwell
  inxi
	fortune
	cowsay
	lolcat
	R
	rstudio
  #developer
  texlive.combined.scheme-full
	nodejs
  hugo
  w3m
  kitty
  mullvad-vpn
  # iterm2 - apparently unsupported on linux (?!). Ah it is a macos terminal of course...
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
cpufrequtils
#	lightlocker
  trash-cli
  jdiskreport
  gnome3.gnome-disk-utility
  aircrack-ng

  networkmanager
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.tlp = {
    enable = true;
    extraConfig = ''
      CPU_SCALING_GOVERNOR_ON_BAT=powersave
      ENERGY_PERF_POLICY_ON_BAT=powersave
  '';
  };


  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 5321 17500 ];
    allowedUDPPorts = [ 17500 ];
  };

  # DNS issue in firefox: https://github.com/NixOS/nixpkgs/issues/63754
  networking.resolvconf.dnsExtensionMechanism = false;
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  #disable bluetooth. doens't work. I still need to sudo rfkill block bluetooth
  hardware.bluetooth.enable = false;
  #also need to disable ethernet manually sudo modprobe -r e1000e  
  #ATM ethernet is disabled in ThinkVantage in BIOS

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  virtualisation.docker.enable = true;

  systemd.user.services.dropbox = {
    description = "Dropbox";
    wantedBy = [ "graphical-session.target" ];
    environment = {
      QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
      QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
    };
    serviceConfig = {
      ExecStart = "${pkgs.dropbox.out}/bin/dropbox";
      ExecReload = "${pkgs.coreutils.out}/bin/kill -HUP $MAINPID";
      KillMode = "control-group"; # upstream recommends process
      Restart = "on-failure";
      PrivateTmp = true;
      ProtectSystem = "full";
      Nice = 10;
    };
  };

  services.xserver = {
  		enable = true;
  		layout = "gb";
  		xkbOptions = "caps:escape, ctrl:swap_lalt_lctl, ctrl:swap_ralt_rctl";
  		displayManager.lightdm.enable = true;
      displayManager.defaultSession = "xfce+xmonad";

  # Enable touchpad support.
		libinput.enable = true;


		desktopManager = {
			xterm.enable = false;
			xfce = {
				enable = true;
				noDesktop = true;
				enableXfwm = false;
			};
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
  system.stateVersion = "20.03"; # Did you read the comment?

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
  alias euclid35="ssh -X 2412135k@euclid-35.maths.gla.ac.uk"
  alias dragon="~/repos/config/dragon.sh"
  alias discord="discord"
'';

programs.zsh.promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh
hardware.opengl.driSupport32Bit = true;
}
