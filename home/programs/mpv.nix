{ pkgs, lib, ... }:

{
  programs.mpv = {
    package = pkgs.celluloid;
    scripts = lib.mkForce [ ];
    config = {
      # Border is required for Celluloid's CSD to render.
      border = "yes";
      autofit-smaller = "1920x1080";
      cursor-autohide = "always";
    };
  };
}
