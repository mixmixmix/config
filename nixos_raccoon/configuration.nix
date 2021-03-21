# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/lenovo/thinkpad/x220>
      ./hardware-configuration.nix
      ./pythonix.nix
      ./common_mixpacks.nix
      ./common_configuration.nix
#      ./spacemacs.nix
    ];
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  #powerManagement.cpuFreqGovernor = null; # will be managed by tlp
  #https://gist.github.com/fikovnik/f9d5283689d663d162d79c061774f79b
  #https://bbs.archlinux.org/viewtopic.php?pid=1030190#p1030190

  #NIXOS-HARDWARE in USE
  #most likely unnecessary since using nixos-hardware repo
  # boot.kernelModules = [ "kvm-intel" ];
  # boot.kernelParams = [
  #   "pcie.aspm=force"
  #   "i915.enable_fbc=1"
  #   "i915.enable_rc6=7"
  #   "i915.lvds_downclock=1"
  #   "i915.enable_guc_loading=1"
  #   "i915.enable_guc_submission=1"
  #   "i915.enable_psr=0"
  # ];


  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  boot.resumeDevice = "/dev/sda2";

  #NIXOS-HARDWARE in USE
  #most likely unnecessary since using nixos-hardware repo
  #boot.extraModulePackages = with config.boot.kernelPackages;[acpi-call tp-smapi];
  #boot.initrd.kernelModules = ["acpi" "thinkpad-acpi" "acpi-call" "tp-smapi" "cpufreq_stats"];
  #boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call tp_smapi];

  networking.hostName = "raccoon"; # Define your hostname.
  networking.networkmanager.enable = true;  # Enables wireless support via wpa_supplicant.
  services.chrony.enable = true; #possibly should be moved to common

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
  #time.timeZone = "Asia/Dhaka";

  services.redshift = {
    enable = true;
    temperature.night = 4000;
  };
  location.latitude = 55.8536;
  location.longitude = -4.2786;




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


  virtualisation.docker.enable = true;

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

}
