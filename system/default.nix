{ pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./bootloader.nix
    ./environment.nix
    ./i18n.nix
    ./networking.nix
    ./packages.nix
  ];

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
}
