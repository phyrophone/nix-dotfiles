{ pkgs, ... }:
{
  imports = [ ../vicinae.nix ];
  
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
  environment.systemPackages = with pkgs; [ wl-clipboard xwayland-satellite ];
  hjem.users.zephyr.xdg = {
    config.files."niri".source = "/home/zephyr/Documents/nixos/hosts/common/niri/config";
    data.files."icons/volantes_cursors".source = "${pkgs.volantes-cursors}/share/icons/volantes_cursors";
  };
}
