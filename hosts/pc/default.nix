{ pkgs, config, ... }:
{
    imports = [
        ./disko.nix
        ./hardware-configuration.nix
        ./../common/default.nix
        ./../common/optional/niri/niri.nix
        ./../common/optional/firefox.nix
        ./../common/optional/music.nix
        ./../common/optional/vicine.nix
        ./../common/optional/git.nix
        ./../common/optional/games.nix
        ./../common/optional/wezterm/wezterm.nix
    ];

    boot.loader.limine.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    users.users.root.hashedPassword = config.users.users.zephyr.hashedPassword;

    users.users.zephyr = {
        isNormalUser = true;
        hashedPassword = "$6$Oph6iIxRn1MHrRIE$RufUKZ9Blc5MtrUup9QmkDU1DK/l53poCZi2/ZbAbsqY0050UmSwStvZ5p5eY/UE4c8vEHzOdb1MZBwH9i.Fx.";
        extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
        shell = pkgs.fish;
    };

    system.stateVersion = "26.05"; # Did you read the comment?
}
