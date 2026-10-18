{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vicinae
  ];

  hjem.users.zephyr.xdg.config.files."vicinae".source = "/home/zephyr/Documents/nixos/common/vicinae/settings.json";
}
