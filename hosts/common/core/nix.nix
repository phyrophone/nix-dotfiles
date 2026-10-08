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
    (final: prev: {
      xwayland-satellite = prev.xwayland-satellite.overrideAttrs (old: rec {
        version = "0.8.1";
          
        src = final.fetchFromGitHub {
          owner = "Supreeeme";
          repo = "xwayland-satellite";
          rev = "536bd32";
          hash = "sha256-BUE41HjLIGPjq3U8VXPjf8asH8GaMI7FYdgrIHKFMXA=";
        };

        cargoDeps = final.rustPlatform.fetchCargoVendor {
          inherit (old) pname;
          inherit version src;
          hash = "sha256-16L6gsvze+m7XCJlOA1lsPNELE3D364ef2FTdkh0rVY=";
        };
      });
    })
    (final: prev: {
      kdePackages = prev.kdePackages // {
        kclock = prev.kdePackages.kclock.overrideAttrs ({
          src = inputs.kclock;
        });
      };
    })
  ];

  programs.nh.enable = true;

  environment.systemPackages = with pkgs; [
    nix-output-monitor
  ];
}
