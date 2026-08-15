{ pkgs, ... }:
{
  environment.sessionVariables.WEZTERM_CONFIG_FILE = "/home/zephyr/Documents/nixos/hosts/common/optional/wezterm/wezterm.lua";
  environment.systemPackages = [ pkgs.wezterm ];
}
