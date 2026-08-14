{ lib, inputs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
    "steam" "steam-unwrapped"
  ];
  
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.nh = {
    enable = true;
    flake = "/home/zephyr/Documents/nixos";
  };
}
