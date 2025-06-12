{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";


    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  };

  outputs = inputs@{ nixpkgs, ... }: let
    system = "x86_64-linux";
    host = "fridge";
    username = "liam";

    # forAllSystems = nixpkgs.lib.genAttrs system;
  in {
    nixosConfigurations = {

      fridge = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host;
        };
        modules = [
          ./hosts/${host}
          ./modules/core
          ./modules/drivers
        ];
      };
      # selfdestruction = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
	    #     ./nixos/configuration.nix
      #     (import ./nixos/firefox.nix {
      #       inherit firefox-addons;
      #     })
	    #     nixos-hardware.nixosModules.framework-12th-gen-intel
      #     # make home-manager as a module of nixos
      #     # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
      #     home-manager.nixosModules.home-manager
      #     {
      #       home-manager.useGlobalPkgs = true;
      #       home-manager.useUserPackages = true;

      #       home-manager.users.liam = import ./home/home.nix;
      #     }
      #   ];
      # };
    };
  };
}
