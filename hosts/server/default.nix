{ pkgs, ... }:
{
  imports = [
    ./disks.nix
    
    ../common/default.nix
    ../common/sudo.nix
  ];

  networking.hostName = "server";

  users.mutableUsers = false;
  users.users = {
    admin = {
      isNormalUser = true;
      hashedPassword = "$6$HTXrRUrN1jxFy0fs$tf8u6lrQY7N8M8bUAJFH2t1LnpZgSx3Cwc/XQeFlPusjAGBcWW5puiKTKt4BeUHGiTWLl.Fd.Ip4.KrCjVZgm/";
      extraGroups = [ "wheel" ];
      shell = pkgs.fish;
    };
    normal = {
      isNormalUser = true;
      hashedPassword = "$6$64ss366iPPtaMMOJ$9Cne9W6BBzrfV9W0XoaTiIbFjmMzJ6DqguG1LrnBKgxfaT.3wTFiuZlDUb.t7y/xOMGmTTFp42GyqXK9k2/TI0";
      shell = pkgs.fish;
    };
    local = {
      isNormalUser = true;
      password = "";
      shell = pkgs.fish;
    };
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      DenyUsers = [ "local" ];
    };
  };

  system.stateVersion = "26.11";
}
