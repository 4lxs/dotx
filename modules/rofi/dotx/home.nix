_inputs: {
  pkgs,
  lib,
  config,
  ...
}: let
  libx = config.lib.dotx;
in {
  options.dotx.rofi = libx.mkTargetOption "rofi";

  config = lib.mkIf config.dotx.rofi.enable {
    # programs.rofi = {
    #   enable = true;
    #   package = pkgs.rofi-wayland;
    #   plugins = with pkgs; [ rofi-blocks ];
    # };
  };
}
