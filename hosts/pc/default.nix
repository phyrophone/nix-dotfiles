{ pkgs, config, ... }:
{
  imports = [
    ./disko.nix
    ./../common/preservation.nix
    ./hardware-configuration.nix

    ./../common/default.nix
    ./../common/niri/niri.nix
    ./../common/firefox.nix
    ./../common/entertainment/games.nix
    ./../common/entertainment/vesktop.nix
    ./../common/entertainment/music.nix
    ./../common/wezterm/wezterm.nix
    ./../common/vscode.nix
    ./../common/direnv.nix
    ./../common/clock.nix
  ];

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;

  users.users.root.hashedPassword = config.users.users.zephyr.hashedPassword;

  networking.hostName = "pc";

  programs.nh.flake = "/home/zephyr/Documents/nixos";

  users.users.zephyr = {
    isNormalUser = true;
    hashedPassword = "$6$Oph6iIxRn1MHrRIE$RufUKZ9Blc5MtrUup9QmkDU1DK/l53poCZi2/ZbAbsqY0050UmSwStvZ5p5eY/UE4c8vEHzOdb1MZBwH9i.Fx.";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  hjem.users.zephyr = {
    enable = true;
    user = "zephyr";
    directory = "/home/zephyr";
  };

  system.stateVersion = "26.05"; # Did you read the comment?
}
