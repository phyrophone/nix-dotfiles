{ pkgs, ...}: {
  programs.starship = {
    enable = true;
    presets = [ "nerd-font-symbols" ];
    transientPrompt.enable = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting

      function mkcd
        mkdir -pv $argv[1]
        cd $argv[1]
      end

      function last_history_item; echo $history[1]; end
      abbr -a !! --position anywhere --function last_history_item

      function nix_run_pkg; echo "nix run nixpkgs#"; end
      function nix_shell_pkg; echo "nix shell nixpkgs#"; end
      abbr -a nxrp --position command --function nix_run_pkg
      abbr -a nxsp --position command --function nix_shell_pkg
    '';
  };  

  environment.shellAliases = {
    la="eza -al --color=always --group-directories-first --icons --hyperlink auto";  # all files and dirs
    ls="eza -al --color=always --group-directories-first --icons --no-user --no-permissions --hyperlink auto"; # preferred listing
    lss="eza -l --color=always --group-directories-first --icons --no-user --no-permissions --no-time --no-filesize --hyperlink auto";  # simple
    lt="eza -aT --color=always --group-directories-first --icons --hyperlink auto"; # tree listing
    tree="lt";
    "l."="eza -al --ignore-glob '[!.]*' --color=always --group-directories-first --icons=always --hyperlink auto"; # show only dotfiles
    lc="l.";
  };

  environment.systemPackages = with pkgs; [
    eza
    fzf
    zip unzip
  ];
}
