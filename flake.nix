{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms-cli = {
      url = "github:AvengeMedia/danklinux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
      inputs.dms-cli.follows = "dms-cli";
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
  };

  outputs = { self, nixpkgs, home-manager, niri, dankMaterialShell, lanzaboote, claude-code, nixcord, stylix, nix-vscode-extensions, ... }@inputs: {
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
