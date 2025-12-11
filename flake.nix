{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.11";

    nix-gaming.url = "github:fufexan/nix-gaming";

    nixarr.url = "github:rasmus-kirk/nixarr";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    caelestia.url = "github:caelestia-dots/shell";
    caelestia.inputs.nixpkgs.follows = "nixpkgs";

    nix-search-tv.url = "github:3timeslazy/nix-search-tv";
    nix-search-tv.inputs.nixpkgs.follows = "nixpkgs";

    nox.url = "github:madsbv/nix-options-search";
    nox.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-alien.inputs.nixpkgs.follows = "nixpkgs";

    nix-reshade.url = "github:LovingMelody/nix-reshade";
    nix-reshade.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";

    nixos-xivlauncher-rb.url = "github:The1Penguin/nixos-xivlauncher-rb";
    nixos-xivlauncher-rb.inputs.nixpkgs.follows = "nixpkgs";

    silentSDDM.url = "github:uiriansan/SilentSDDM";
    silentSDDM.inputs.nixpkgs.follows = "nixpkgs";

    # DankMaterialShell dependencies
    dgop.url = "github:AvengeMedia/dgop";
    dgop.inputs.nixpkgs.follows = "nixpkgs";

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-xivlauncher-rb, nix-alien, nur, nixarr, ... }@inputs:
    let
      overlays =
        [
          inputs.nix-alien.overlays.default
          nur.overlays.default
        ]
        ++ (import ./overlays { inherit inputs; });

      specialArgs = { inherit inputs overlays username; };
      system = "x86_64-linux";
      username = "wolfy";
    in {
      nixosConfigurations = {
        host = nixpkgs.lib.nixosSystem {
          specialArgs = specialArgs // { hostname = "host"; };
          modules = [
          nixarr.nixosModules.default
          ./configuration.nix
		      ./packages
          ./modules/media.nix
		      nixos-xivlauncher-rb.nixosModules.default
		      ];
        };
      };

      homeConfigurations = let
        pkgs = nixpkgs.legacyPackages.${system};
        config = {
          inherit pkgs;
          extraSpecialArgs = specialArgs;
        };

      in {
        # TODO: consider having this be a fallback - i.e., just set the username, not the hostname
        "${username}@host" = home-manager.lib.homeManagerConfiguration
          (config // { modules = [ ./home ]; });
      };
    };
}
