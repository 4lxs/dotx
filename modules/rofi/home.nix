{
  pkgs,
  lib,
  config,
  libx,
  ...
}:
{
  options.dotx.rofi.enable = libx.mkEnableTarget "rofi";

  config = lib.mkIf config.dotx.rofi.enable {
    # programs.rofi = {
    #   enable = true;
    #   package = pkgs.rofi-wayland;
    #   plugins = with pkgs; [ rofi-blocks ];
    # };
  };
}
