{ lib, ... }:

{
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "atsuko";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
}
