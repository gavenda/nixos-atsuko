# Desktop Configuration

{ pkgs, ... }:

{
  # Enable GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  programs.dconf.enable = true;

  # Enable xdg desktop integration.
  xdg.portal = {
    enable = true;
    # Screenshare
    wlr.enable = true;
  };

  # Exclude XTerm
  services.xserver.excludePackages = [ pkgs.xterm ];
}
