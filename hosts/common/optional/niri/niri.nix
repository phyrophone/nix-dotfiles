{ pkgs, lib, config, inputs, ... }:
{
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;

  services.displayManager.sddm.enable = true;
  services.xserver.enable = true;

  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

  environment.systemPackages = with pkgs; [ wl-clipboard xwayland-satellite ];
  hjem.users.zephyr = {
    files = {
      ".config/niri" = {
        source = "/home/zephyr/Documents/nixos/hosts/common/optional/niri/config";
      };
    };
  };
}
