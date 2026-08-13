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
  };

  outputs = inputs: {
    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
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
  };
}
