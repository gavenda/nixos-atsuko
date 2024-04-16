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
    };

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "i915.fastboot=1"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  console = {
    font = "ter-132n";
    packages = [pkgs.terminus_font];
    useXkbConfig = true;
    earlySetup = false;
  };
}
