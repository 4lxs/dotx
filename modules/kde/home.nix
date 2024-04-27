{
  config,
  lib,
  libx,
  ...
}:
with lib;
{
  options.dotx.kde.enable = libx.mkEnableTarget "kde theming";

  config = mkIf config.dotx.kde.enable {
    # TODO: kvantum adw-gtk3
    qt = {
      enable = true;
      platformTheme = "gnome";
      style.name = if config.dotx.theme.darkTheme then "adwaita-dark" else "adwaita";
    };
  };
}
