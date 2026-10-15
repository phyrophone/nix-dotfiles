{ pkgs, ... }:
{
  environment.sessionVariables.WEZTERM_CONFIG_FILE = "/home/zephyr/Documents/nixos/hosts/common/wezterm/wezterm.lua";
  environment.systemPackages = [ pkgs.wezterm ];
  environment.shellAliases = {
    window="wezterm start --cwd . 2>/dev/null";
    tab="wezterm start --new-tab --cwd . 2>/dev/null";
  };
}
