{
  boot.tmp.cleanOnBoot = true;

  preservation = {
    enable = true;

    preserveAt."/persistent" = {
      directories = [
        "/var/lib/systemd/timers"
        "/var/lib/nixos"
        "/var/log"
        "/etc/nixos"
        "/tmp"
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
      ];

      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];

      # Preserve user files
      users.zephyr = {
        directories = [
        "Documents"
        ".config/mozilla"
        ];
          files = [];
      };
    };
  };

  # systemd.tmpfiles.rules = [
  #   "d /tmp 1777 root root - -"
  # ];
  systemd.tmpfiles.settings = {
    "preservation"."/tmp".d = {
      group = "root";
      mode = "1777";
      user = "root";
    };
  };
  # systemd-machine-id-commit.service would fail, but it is not relevant
  # in this specific setup for a persistent machine-id so we disable it
  #
  # see the firstboot example below for an alternative approach
  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
}
