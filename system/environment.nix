# System environment configuration

{ pkgs, ... }:

{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.shells = with pkgs; [ zsh ];
}
