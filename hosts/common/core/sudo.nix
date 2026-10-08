{ ... }:
{
  security.sudo-rs = {
    enable = true;
    extraConfig = ''
      Defaults lecture = never
    '';
  };
}
