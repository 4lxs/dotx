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
      font = libx.cfg.theme.font.sansserif;
      theme = {
        package = pkgs.adw-gtk3;
        name =
          if libx.cfg.theme.darkTheme
          then "adw-gtk3-dark"
          else "adw-gtk3";
      };
      iconTheme = {
        name = "MoreWaita";
        package = pkgs.morewaita-icon-theme;
      };
    };
    home = {
      pointerCursor = {
        name = "Qogir";
        size = 24;
        package = pkgs.qogir-icon-theme;
        gtk.enable = true;
      };
      sessionVariables = {
        XCURSOR_THEME = "Qogir";
        XCURSOR_SIZE = "24";
      };
    };
    dconf.settings."org/gnome/desktop/interface" = {
      color-scheme =
        if libx.cfg.theme.darkTheme
        then "prefer-dark"
        else "prefer-light";
    };
  };
}
