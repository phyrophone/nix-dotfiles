{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vicinae
  ];
}
