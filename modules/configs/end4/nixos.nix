_inputs: {
  config,
  lib,
  ...
}: let
  libx = config.lib.dotx;
in {
  config = lib.mkIf libx.cfg.configs.end4.enable {
    services.upower.enable = true;
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
