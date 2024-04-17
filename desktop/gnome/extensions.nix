{ pkgs, lib, ... }:

{
  environment = {
    # https://github.com/fflewddur/tophat/issues/106#issuecomment-1848319826
    variables.GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0";
    systemPackages = [ pkgs.libgtop ] ++ (with pkgs.gnomeExtensions; [
      native-window-placement
      panel-date-format
      astra-monitor
    ]);
  };

  programs.dconf.profiles.user.databases = [{
    settings = with lib.gvariant; {
      "org/gnome/shell/extensions/panel-date-format".format = "%Y-%m-%d %H:%M";
    };
  }];
}
