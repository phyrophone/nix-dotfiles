{  pkgs, ... }:
{
    imports = [
        ./preservation.nix
        ./core/nix.nix
        ./core/helix.nix
        ./core/shell.nix
        ./core/xdg-vars.nix
        ./core/git.nix
    ];

    hjem.users.zephyr = {
        user = "zephyr";
        directory = "/home/zephyr";
        enable = true;
    };

    time.timeZone = "Europe/Stockholm";

    networking.networkmanager.enable = true;

    environment.systemPackages = with pkgs; [
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        nano
        git
        alacritty
        kdePackages.kate
    ];

    fonts.packages = with pkgs; [
        nerd-fonts.symbols-only
        fira-code
        
        # (google-fonts.overrideAttrs {
        #     fonts = [
                
        #     ];
        # })
    ];
}
