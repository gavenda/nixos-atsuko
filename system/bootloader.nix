# Bootloader Configuration

{ pkgs, ... }:

{

  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;

    # Use the systemd-boot EFI boot loader.
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      theme = "bgrt"; 
    };

    kernelParams = [
      "quiet" 
      "udev.log_level=0" 
    ];
  };

  console = {
    font = "ter-u14n";
    packages = [pkgs.terminus_font];
    useXkbConfig = true;
    earlySetup = false;
  };
}
