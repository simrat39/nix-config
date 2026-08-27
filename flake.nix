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
      url = "github:nix-community/lanzaboote/v1.1.0";
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
      # ponytail: pinned to match april-2026 nixpkgs; unpin when nixpkgs is updated
      url = "github:Gerg-L/spicetify-nix/8b00357d910c5281181c21fc3a0d071ceec80c06";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claude-desktop = {
      url = "github:aaddrick/claude-desktop-debian/e5cc4b21f8a0be95f2d1c52e99d5c6f92a0e83cf";
    };

    # upstream pingdotgg/t3code has no flake.nix; this packages its release AppImage
    t3code = {
      url = "github:omarcresp/t3code-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, niri, dms, lanzaboote, claude-code, nixcord, stylix, nix-vscode-extensions, spicetify-nix, claude-desktop, ... }@inputs:
    let
      mkHost = { hostName, extraModules ? [] }: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs hostName; };
        modules = [
          ./hosts/${hostName}/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.simrat39 = import ./hosts/${hostName}/home.nix;
            home-manager.extraSpecialArgs = { inherit self inputs hostName; };
          }

          niri.nixosModules.niri
          ({ pkgs, ... }: {
            programs.niri.enable = true;
            nixpkgs.overlays = [
              niri.overlays.niri
              # ponytail: nixpkgs bumped libdisplay-info to 0.4.0 but niri's
              # libdisplay-info-sys crate requires < 0.4.0, so build the real
              # 0.2.0 (hash from nixos-25.05). Drop once niri accepts 0.4.
              (final: prev: {
                libdisplay-info_0_2 = prev.libdisplay-info.overrideAttrs (old: rec {
                  version = "0.2.0";
                  src = final.fetchFromGitLab {
                    domain = "gitlab.freedesktop.org";
                    owner = "emersion";
                    repo = "libdisplay-info";
                    tag = version;
                    hash = "sha256-6xmWBrPHghjok43eIDGeshpUEQTuwWLXNHg7CnBUt3Q=";
                  };
                });
              })
            ];
            programs.niri.package = pkgs.niri-unstable;
          })

          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              claude-code.overlays.default
              claude-desktop.overlays.default
              nix-vscode-extensions.overlays.default
            ];
          })

          stylix.nixosModules.stylix
        ] ++ extraModules;
      };

      lanzabooteModules = [
        lanzaboote.nixosModules.lanzaboote
        ({ pkgs, lib, ...}: {
          boot.loader.systemd-boot.enable = lib.mkForce false;
          boot.lanzaboote = {
            enable = true;
            pkiBundle = "/var/lib/sbctl";
          };
        })
      ];
    in {
      nixosConfigurations = {
        simpc = mkHost {
          hostName = "simpc";
          extraModules = lanzabooteModules;
        };
        simbook = mkHost {
          hostName = "simbook";
        };
      };
    };
}
