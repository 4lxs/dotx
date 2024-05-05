_inputs:
{
  config,
  lib,
  libx,
  pkgs,
  ...
}:
with lib;
{
  options.dotx.gtk = libx.mkTargetOption "gtk theming";

  config = mkIf config.dotx.gtk.enable {
    gtk = {
      enable = true;
      # inherit (config.dotx.theme) font;
      theme = {
        package = pkgs.adw-gtk3;
        name = if config.dotx.theme.darkTheme then "adw-gtk3-dark" else "adw-gtk3";
      };
      # iconTheme = {
      #   package = pkgs.gnome.adwaita-icon-theme;
      #   name = "adwaita-icon-theme";
      # };
    };
    dconf.settings."org/gnome/desktop/interface" = {
      color-scheme = if config.dotx.theme.darkTheme then "prefer-dark" else "prefer-light";
    };
  };
}
