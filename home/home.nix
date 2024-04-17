{ pkgs, ...}: {
  imports = [
    ./programs
  ];

  home = {
    username = "enda";
    homeDirectory = "/home/enda";
  };

  home.packages = with pkgs; [
    fractal
    mautrix-meta
    signal-desktop
    firefox
    discord
    vscode
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "24.05";

  gtk = {
    enable = true;

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 0;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 0;
    };

    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };

    font = {
      name = "Noto Sans";
      package = pkgs.noto-fonts;
      size = 11;
    };
  };
}
