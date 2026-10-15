{ pkgs, ... }:
{
  imports = [
    ../vicinae.nix
    ../graphical.nix
  ];

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;

  services.displayManager.sddm.enable = true;
  services.xserver.enable = true;

  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    xwayland-satellite
  ];
  hjem.users.zephyr.xdg.config.files."niri".source =
    "/home/zephyr/Documents/nixos/common/niri/config";
}
