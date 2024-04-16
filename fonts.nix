{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # Monospace
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      fira-code
      # Noto Sans
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      # Source Code
      source-code-pro
      source-sans-pro
      source-serif-pro
      # Liberation
      liberation_ttf
      # Microsoft
      corefonts
    ];

    fontconfig = {
      antialias = true;
      cache32Bit = true;
      hinting.enable = true;
      hinting.autohint = true;
      defaultFonts = {
        monospace = [ "Source Code Pro" ];
        sansSerif = [ "Source Sans Pro" ];
        serif = [ "Source Serif Pro" ];
      };
    };
  };
}
