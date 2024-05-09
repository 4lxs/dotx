_inputs: {
  pkgs,
  lib,
  config,
  ...
}: let
  libx = config.lib.dotx;
in {
  config = lib.mkIf libx.cfg.rofi.enable {
    # programs.rofi = {
    #   enable = true;
    #   package = pkgs.rofi-wayland;
    #   plugins = with pkgs; [ rofi-blocks ];
    # };
  };
}
