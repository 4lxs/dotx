{
  config,
  pkgs,
  lib,
  libx,
  ...
}:
with lib;
{
  config = mkIf (config.dotx.system == "hyprland") {
    dotx = mkIf config.dotx.autoEnable {
      kitty.enable = true;
      waybar.enable = true;
    };
  };
}
