_inputs:
{
  config,
  lib,
  libx,
  ...
}:
with lib;
let
  dunstOpacity = toHexString ((builtins.ceil (config.dotx.theme.transparency * 100)) * 255 / 100);
in
{
  options.dotx.dunst = libx.mkTargetOption "dunst notification daemon";

  config = mkIf config.dotx.dunst.enable {
    services.dunst = {
      enable = true;
      settings = with config.dotx.theme.base16.withHashtag; {
        global = {
          separator_color = base02;
          font = with config.dotx.theme.font; "${sansserif.name} ${toString size.gui}";
          mouse_left_click = "do_action, close_current";
        };

        urgency_low = {
          background = base01 + dunstOpacity;
          foreground = base05;
          frame_color = base0B;
        };

        urgency_normal = {
          background = base01 + dunstOpacity;
          foreground = base05;
          frame_color = base0E;
        };

        urgency_critical = {
          background = base01 + dunstOpacity;
          foreground = base05;
          frame_color = base08;
        };
      };
    };
  };
}
