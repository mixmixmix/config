# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

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

  boot.initrd.kernelModules = ["i915" "acpi" "thinkpad-acpi" "acpi-call" "tp-smapi" "cpufreq_stats"];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
    intel-media-driver
  ];

  boot = {
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call tp_smapi];
  };


  # networking
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;

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
  boot.resumeDevice = "/dev/sda1";
  # TODO implement better energy saving ?
  #boot.extraModulePackages = with config.boot.kernelPackages;[acpi-call tp-smapi];

  networking.hostName = "chipmunk"; # Define your hostname.
  networking.networkmanager.enable = true;  # Enables wireless support via wpa_supplicant.
  services.chrony.enable = true;
  # DNS issue in firefox: https://github.com/NixOS/nixpkgs/issues/63754
  networking.resolvconf.dnsExtensionMechanism = false;
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" ];

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
  # time.timeZone = "Europe/Warsaw";
  time.timeZone = "Europe/London";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  hardware.opengl.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 17500 ];
    allowedUDPPorts = [ 17500 ];
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  virtualisation.docker.enable = true;
  programs.adb.enable = true; #some sort of android subsystem
  services.xserver = {
  		enable = true;
  		layout = "gb";
  		xkbOptions = "caps:escape, ctrl:swap_lalt_lctl, ctrl:swap_ralt_rctl";
  		displayManager.lightdm.enable = true;
      #videoDrivers = ["nvidia"];
      displayManager.defaultSession = "xfce+xmonad";
  # Enable touchpad support.
		libinput.enable = true;
		desktopManager = {
		xterm.enable = true;
		xfce = {
			enable = true;
			noDesktop = true;
			enableXfwm = false;
			};
		gnome3.enable = true;
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

	programs.zsh.enable = true;
  #
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mix = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "sudo" "networkmanager" "docker" "adbusers"]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  #system.stateVersion = "20.03"; # Using unstable now
  nixpkgs.config.allowBroken = true;
  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/1 * * * *     mix    . /etc/profile; /home/mix/repos/organutan/pushme_badger.sh >> /home/mix/repos/organutan/autopush.log"
      "*/5 * * * *      root    date >> /tmp/cron.log"
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
  plugins=(git vi-mode)

  source $ZSH/oh-my-zsh.sh
  alias euclid35="ssh -X 2412135k@euclid-35.maths.gla.ac.uk"
alias dragon="~/repos/config/dragon.sh"

'';

programs.zsh.promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh

hardware.opengl.driSupport32Bit = true;
hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
}

