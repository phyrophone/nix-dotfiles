{pkgs, lib, config, ... }: {
  environment.systemPackages = with pkgs; [
    spotify

    musescore
    muse-sounds-manager
    audacity
  ];
}
