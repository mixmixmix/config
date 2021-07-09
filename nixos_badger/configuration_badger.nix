# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

  let
    unstable = import <nixos-unstable> {config = { allowUnfree = true; };};
  in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./pythonix.nix
      ./common_mixpacks.nix
      ./common_configuration.nix
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

  boot.extraModulePackages = with config.boot.kernelPackages;[ rtl88x2bu ];
  networking.hostName = "badger"; # Define your hostname.
  networking.networkmanager.enable = true;  # Enables wireless support via wpa_supplicant.
  services.chrony.enable = true;
  # DNS issue in firefox: https://github.com/NixOS/nixpkgs/issues/63754
  networking.resolvconf.dnsExtensionMechanism = false;
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  #hardware.nvidia.optimus_prime.enable = true;
  #hardware.nvidia.optimus_prime.nvidiaBusId = "PCI:1:0:0";
  #hardware.nvidia.optimus_prime.intelBusId = "PCI:0:2:0";
  hardware.opengl.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # services.printing.drivers = with pkgs; [ cnijfilter_4_00 ];

    environment.systemPackages = with pkgs; [
      # unstable.steam #if ever need to use from unstable
      cudatoolkit
      linuxPackages.nvidia_x11
      blender
    ];

    nixpkgs.config.packageOverrides = pkgs: {
      blender = pkgs.blender.override {
        cudaSupport = true;
        cudatoolkit = pkgs.cudatoolkit;
      };
    };


  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/1 * * * *     mix    . /etc/profile; /home/mix/repos/organutan/pushme_badger.sh >> /home/mix/repos/organutan/autopush.log"
    ];
  };

  swapDevices = [
    { device = "/dev/nvme0n1p2";
    }
  ];

nixpkgs.config.allowUnfree = true;

hardware.opengl.driSupport32Bit = true;
hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
}
