# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/lenovo/thinkpad/t460s>
      ./hardware-configuration.nix
      ./pythonix.nix
      ./common_mixpacks.nix
      ./common_configuration.nix
#      ./spacemacs.nix
    ];

  environment.systemPackages = with pkgs; [
    intel-gpu-tools
  ];

  powerManagement.enable = true;
  powerManagement.powertop.enable = true;


  #NIXOS-HARDWARE in USE
  #most likely unnecessary since using nixos-hardware repo
  #boot.initrd.kernelModules = ["i915" "acpi" "thinkpad-acpi" "acpi-call" "tp-smapi" "cpufreq_stats"];
  #hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # hardware.opengl.extraPackages = with pkgs; [
  #   vaapiIntel
  #   vaapiVdpau
  #   libvdpau-va-gl
  #   intel-media-driver
  # ];

  # boot = {
  #   kernelModules = [ "acpi_call" "coretemp" "cpuid" ];
  #   extraModulePackages = with config.boot.kernelPackages; [ acpi_call tp_smapi];
  # };


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

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  hardware.opengl.enable = true;

  virtualisation.docker.enable = true;

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

 hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
}

