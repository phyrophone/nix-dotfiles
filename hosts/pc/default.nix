{ pkgs, ... }:
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
    ];

    boot.loader.limine.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    users.users.zephyr = {
        isNormalUser = true;
        initialPassword = "1234";
        extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
        shell = pkgs.fish;
    };

    system.stateVersion = "26.05"; # Did you read the comment?
}
