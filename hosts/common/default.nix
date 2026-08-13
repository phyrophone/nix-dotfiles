{  pkgs, ... }:
{
    imports = [
        ./preservation.nix
        ./core/nix.nix
        ./core/helix.nix
        ./core/shell.nix
    ];

    hjem.users.zephyr = {
        user = "zephyr";
        directory = "/home/zephyr";
        enable = true;
    };

    time.timeZone = "Europe/Stockholm";

    networking.hostName = "nixos"; # Define your hostname.

    networking.networkmanager.enable = true;

    environment.systemPackages = with pkgs; [
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        nano
        git
        alacritty
        kdePackages.kate
        wezterm
    ];
}
