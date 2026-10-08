{ pkgs, repo-src, ... }:
{
  imports = [
    ../common/default.nix
    ../common/firefox.nix
    ../common/wezterm/wezterm.nix
  ];

  networking.hostName = "iso";

  environment.systemPackages = with pkgs; [
    gum
    # taken from https://haseebmajid.dev/posts/2024-02-04-how-to-create-a-custom-nixos-iso/
    (writeShellScriptBin "nix-installer" ''
      REPO_URL="https://github.com/phyrophone/nix-dotfiles"

      if [ "$(id -u)" -eq 0 ]; then
      	echo "ERROR! $(basename "$0") should be run as a regular user"
      	exit 1
      fi

      if [ ! -d "$HOME/dotfiles/.git" ]; then
        echo "Should the local copy of the dotfiles be used, or should they be redownloaded?"
        REPO_SOURCE="$(gum choose "use local copy" "download new copy")"
        if [ "$REPO_SOURCE" = "use local copy" ]; then
          cp -r "${repo-src}/." "$HOME/dotfiles"
        elif [ "$REPO_SOURCE" = "download new copy" ]; then
          gh auth login
          git clone "$REPO_URL" "$HOME/dotfiles"
        else
          echo "ERROR! Answered $REPO_SOURCE, which isn't a valid answer"
          exit 1
        fi
      fi

      echo "Which host should be installed?"
      TARGET_HOST=$(ls -1 ~/dotfiles/hosts/*/default.nix |\
        cut -d'/' -f6 |\
        grep -v iso | grep -v common |\
        gum choose)

      if [ ! -e "$HOME/dotfiles/hosts/$TARGET_HOST/disks.nix" ]; then
      	echo "ERROR! $(basename "$0") could not find the required $HOME/dotfiles/hosts/$TARGET_HOST/disks.nix"
      	exit 1
      fi

      gum confirm  --default=false \
        "WARNING!!!! This will ERASE ALL DATA on the disk $TARGET_HOST. Are you sure you want to continue?"

      echo "Partitioning Disks"
      sudo nix run github:nix-community/disko \
        --extra-experimental-features "nix-command flakes" \
        --no-write-lock-file \
        -- \
        --mode zap_create_mount \
        "$HOME/dotfiles/hosts/$TARGET_HOST/disks.nix"

      sudo nixos-install --flake "$HOME/dotfiles#$TARGET_HOST"
    '')
  ];
}
