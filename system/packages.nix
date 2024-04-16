# System-wide packages

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
  ];
}
