{ pkgs, ...}: {
  imports = [
    ./programs
  ];

  home = {
    username = "enda";
    homeDirectory = "/home/enda";
  };

  home.packages = with pkgs; [
    firefox
    discord
    vscode
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "24.05";
}
