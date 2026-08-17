{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix

        llvm-vs-code-extensions.vscode-clangd
        llvm-vs-code-extensions.lldb-dap
        xaver.clang-format
      ];
    })
  ];
}
