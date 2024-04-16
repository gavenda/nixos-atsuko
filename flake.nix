{
  description = "Enda's NixOS System - Atsuko";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, aagl, home-manager, ... } @ inputs: {
    nixosConfigurations.atsuko = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hardware
        ./system
        ./programs
        ./users.nix
        ./desktop.nix
        ./virtualization.nix
        aagl.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.enda = import ./home/home.nix;
        }
        {
          nix.settings = aagl.nixConfig;
          programs.anime-games-launcher.enable = true;
        }
      ];
    };
  };
}
