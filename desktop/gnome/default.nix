# Desktop Configuration

{ lib, pkgs, ... }:

{
  imports = [
    ./debloat.nix
    ./extensions.nix
    ./mime.nix
  ];

  programs.dconf.enable = true;

  # Enable xdg desktop integration.
  xdg.portal = {
    enable = true;
    # Screenshare
    wlr.enable = true;
  };

  services.xserver = {
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      autoSuspend = false;
    };
  };

  environment.systemPackages = with pkgs; [
    adw-gtk3
    morewaita-icon-theme
    # Gnome Circle Apps
    amberol
    komikku
    fragments
  ];

  programs.dconf.profiles = {
    gdm.databases = [{
      settings = {
        # GDM by default is always unscaled compared to the GNOME lockscreen.
        "org/gnome/mutter".experimental-features = [ "scale-monitor-framebuffer" ];
        "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
      };
    }];

    user.databases = [{
      settings = with lib.gvariant; {
        "org/gnome/desktop/calendar".show-weekdate = true;
        "org/gnome/desktop/input-sources".sources = [
          (mkTuple [ "xkb" "us" ])
        ];
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-enable-primary-paste = false;
        };
        "org/gnome/Console" = {
          # Console seems to not be able to actually use the system font correctly,
          # but Monospace also appears to be the real system monospace font.
          use-system-font = false;
          custom-font = "Monospace 11";
        };
        "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
        "org/gnome/desktop/privacy".remember-recent-files = false;
        "org/gnome/desktop/screensaver".lock-enabled = false;
        "org/gnome/desktop/session".idle-delay = mkUint32 0;
        "org/gnome/mutter".experimental-features = [ "scale-monitor-framebuffer" ];
        "org/gnome/nautilus/preferences".default-folder-viewer = "list-view";
        "org/gtk/gtk4/settings/file-chooser" = {
          show-hidden = true;
          sort-directories-first = true;
          view-type = "list";
        };
        # Hidden/background programs only show up if they are flatpaks,
        # so disable background play for now.
        "io/bassi/Amberol".background-play = false;
        "org/gnome/settings-daemon/plugins/media-keys" = {
          screenreader = mkEmptyArray type.string;
          magnifier = mkEmptyArray type.string;
          calculator = [ "<Super>c" ];
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Super>Return";
          command = "/usr/bin/env kgx";
          name = "Terminal";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          binding = "<Super>e";
          command = "/usr/bin/env nautilus";
          name = "File Manager";
        };

        # This is necessary for some reason, or the above custom-keybindings don't work.
        "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
      };
    }];
  };
}
