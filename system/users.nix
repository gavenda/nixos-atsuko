{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  users.users.enda = {
    isNormalUser = true;
    extraGroups = [ "wheel" "podman" ];
  };
}
