# Desktop Configuration

{ pkgs, ... }:

{
  # Enable GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Screenshare
  xdg.portal.wlr.enable = true;

  # Exclude XTerm
  services.xserver.excludePackages = [ pkgs.xterm ];
}
