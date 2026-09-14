{ lib, inputs, pkgs,  ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
    "steam" "steam-unwrapped"
    "muse-sounds-manager"
  ];

  nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" /* cachyos */ ];
  nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" /* cachyos */ ];
  
  nixpkgs.overlays = [
    inputs.niri.overlays.niri
    inputs.nix-cachyos-kernel.overlays.pinned
  ];

  programs.nh.enable = true;

  environment.systemPackages = with pkgs; [
    nix-output-monitor
  ];
}
