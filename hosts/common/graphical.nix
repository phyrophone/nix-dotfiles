{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ kdePackages.breeze-icons ];
  
  qt = {
    enable = true;

    # "adwaita", "adwaita-dark", "adwaita-highcontrast" and "adawaita-highcontrastinverse"
    # options use adwaita-qt, which was archived
    # "bb10bright", "bb10dark", "cleanlooks", "gtk2", "motif" and "plastique"
    # options use qtstyleplugins, which was last updated 9 years ago
    # Other options are "breeze", "kvamtum"
    style = "breeze";

    # "gnome" option uses qgnomeplatform, which was archived
    # "gtk" option uses qtstyleplugins, which was last updated 9 years ago
    # Other options are "lxqt", "kde", or "qt5ct"
    platformTheme = "kde";
  };

  hjem.users.zephyr.xdg.data.files."icons/volantes_cursors".source =
    "${pkgs.volantes-cursors}/share/icons/volantes_cursors";
}
