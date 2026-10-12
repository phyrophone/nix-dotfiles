{ ... }:
{
  disko.devices = {
    disk = {
      bigger-disk = {
        device = "/dev/disk/by-id/ata-Samsung_SSD_860_EVO_500GB_S3Z2NB1KB89180M";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
      smaller-disk = {
        device = "/dev/disk/by-id/ata-KINGSTON_RBU-SC100S37128GD_50026B72511446B0";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            smaller-partition = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/extra-disk";
              };
            };
          };
        };
      };
    };
  };
}
