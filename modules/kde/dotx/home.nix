_inputs:
{ config, lib, ... }:
with lib;
let
  libx = config.lib.dotx;
in
{
  options.dotx.kde = libx.mkTargetOption "kde theming";

  config = mkIf config.dotx.kde.enable {
    # TODO: kvantum adw-gtk3
    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style.name = if config.dotx.theme.darkTheme then "adwaita-dark" else "adwaita";
    };
  };
}
