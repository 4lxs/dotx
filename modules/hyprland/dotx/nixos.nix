_inputs: {
  config,
  lib,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.hyprland.enable {
    services.upower.enable = true;
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
    };
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
