{ pkgs, ... }:
{
    imports = [
        ./core/nix.nix
        ./core/helix.nix
        ./core/shell.nix
        ./core/xdg-vars.nix
        ./core/git.nix
    ];

    boot.loader.limine.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    virtualisation.vmVariant = ../vm/default.nix;
    virtualisation.vmVariantWithBootLoader = ../vm/default.nix;

    time.timeZone = "Europe/Stockholm";
    console.keyMap = "sv-latin1";

    i18n.defaultLocale = "en_DK.UTF-8";

    networking.networkmanager.enable = true;

    environment.systemPackages = with pkgs; [
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        nano
        git
        alacritty
    ];

    fonts.packages = with pkgs; [
        nerd-fonts.symbols-only
        fira-code
        noto-fonts # includes fallbacks
    ];
}
