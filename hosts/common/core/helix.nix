{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    helix
    
    # LSP
    nil # nix
    # Formatter
    alejandra # nix
  ];
}
