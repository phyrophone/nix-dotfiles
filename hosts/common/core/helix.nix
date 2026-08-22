{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    helix
    
    # LSP
    nil # nix
    clang clang-tools # cpp
    fish-lsp
    # Formatter
    alejandra # nix
  ];
}
