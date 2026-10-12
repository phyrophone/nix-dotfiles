{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    preservation.url = "github:nix-community/preservation?ref=pull/27/head";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:epireyn/niri-flake";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    # Do not override its nixpkgs input, otherwise there can be mismatch between patches and kernel version

    kclock.url = "github:phyrophone/kclock";
    kclock.flake = false;
  };

  outputs = inputs: {
    nixosConfigurations = {
      pc = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/pc/default.nix
          inputs.disko.nixosModules.disko
          inputs.preservation.nixosModules.default
          inputs.hjem.nixosModules.default
          inputs.niri.nixosModules.niri
        ];
        specialArgs = { inherit inputs; };
      };
      server = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/server/default.nix
          inputs.disko.nixosModules.disko
        ];
        specialArgs = { inherit inputs; };
      };
      iso =
        let
          repo-src = ./.;
        in
        inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix"
            "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
            ./hosts/iso/default.nix
          ];
          specialArgs = { inherit inputs repo-src; };
        };
    };
  };
}
