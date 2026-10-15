{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    helix
    
    # LSP
    nil # nix
    clang clang-tools # cpp
    fish-lsp
    rust-analyzer
    bash-language-server
    # Formatter
    alejandra # nix
  ];
}
