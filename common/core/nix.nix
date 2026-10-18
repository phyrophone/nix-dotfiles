{ lib, inputs, pkgs,  ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
    "steam" "steam-unwrapped"
    "muse-sounds-manager"
    "nvidia-x11" "nvidia-settings" "nvidia-kernel-modules"
  ];

  nix.settings.substituters = [ ];
  nix.settings.trusted-public-keys = [ ];
  
  nixpkgs.overlays = [
    inputs.niri.overlays.niri
    (final: prev: {
      kdePackages = prev.kdePackages // {
        kclock = prev.kdePackages.kclock.overrideAttrs ({
          src = inputs.kclock;
        });
      };
    })
  ];

  programs.nh.enable = true;
  programs.nix-index-database.comma.enable = true;

  environment.systemPackages = with pkgs; [
    nix-output-monitor
  ];
}
