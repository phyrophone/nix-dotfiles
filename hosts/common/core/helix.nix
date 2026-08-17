{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    helix
    
    # LSP
    nil # nix
    clang clang-tools # cpp
    # Formatter
    alejandra # nix
  ];
}
