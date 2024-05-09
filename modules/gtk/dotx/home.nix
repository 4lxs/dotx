_inputs: {
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.gtk.enable {
    gtk = {
      enable = true;
      # inherit (libx.cfg.theme) font;
      theme = {
        package = pkgs.adw-gtk3;
        name =
          if libx.cfg.theme.darkTheme
          then "adw-gtk3-dark"
          else "adw-gtk3";
      };
      # iconTheme = {
      #   package = pkgs.gnome.adwaita-icon-theme;
      #   name = "adwaita-icon-theme";
      # };
    };
    dconf.settings."org/gnome/desktop/interface" = {
      color-scheme =
        if libx.cfg.theme.darkTheme
        then "prefer-dark"
        else "prefer-light";
    };
  };
}
