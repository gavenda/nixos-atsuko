# Nvidia Configuration
{ config, ... }:

{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };
  
  services.xserver.videoDrivers = ["nvidia"];
}
