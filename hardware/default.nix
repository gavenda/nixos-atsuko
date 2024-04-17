# Hardware Configuration
{ config, lib, modulesPath, pkgs, ... }:

{
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
    ./nvidia.nix
    ./xbox.nix
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  fileSystems."/" =
    { device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" "discard=async" "subvol=root" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" "discard=async" "subvol=home" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" "discard=async" "subvol=nix"  ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/swap" =
    { device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = [ "noatime" "discard=async" "subvol=swap" ];
    };

  swapDevices = [
    { device = "/swap/swapfile"; }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  # Tweaks CPU scheduler for responsiveness over throughput.
  programs.cfs-zen-tweaks.enable = true;
}
