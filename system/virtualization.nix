{ pkgs, ... }:

{
   environment.systemPackages = [
     # Do install the docker CLI to talk to podman.
     # Not needed when virtualisation.docker.enable = true;
    pkgs.docker-client
  ];

  virtualisation.docker.enable = false;

  virtualisation.podman = {
    enable = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  virtualisation.containers.storage.settings = {
    storage = {
      driver = "btrfs"; 
    };
  };
}
