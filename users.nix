{ ... }:

{
  users.users.enda = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" ];
  };
}
