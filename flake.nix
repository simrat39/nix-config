{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claude-code = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, niri, dms, lanzaboote, claude-code, nixcord, stylix, nix-vscode-extensions, spicetify-nix, ... }@inputs: {
    nixosConfigurations.simpc = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/simpc/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.simrat39 = import ./hosts/simpc/home.nix;
          home-manager.extraSpecialArgs = { inherit self inputs; };
        }

        niri.nixosModules.niri
	      ({ pkgs, ... }: {
	        programs.niri.enable = true;
          nixpkgs.overlays = [
            niri.overlays.niri
          ];
          programs.niri.package = pkgs.niri-unstable;
	      })

        ({ pkgs, ... }: {
          nixpkgs.overlays = [
            claude-code.overlays.default
            nix-vscode-extensions.overlays.default
          ];
        })

	      stylix.nixosModules.stylix

        lanzaboote.nixosModules.lanzaboote
        ({ pkgs, lib, ...}: {
          boot.loader.systemd-boot.enable = lib.mkForce false;
          boot.lanzaboote = {
            enable = true;
            pkiBundle = "/var/lib/sbctl";
          };
        })
      ];
    };
  };
}
