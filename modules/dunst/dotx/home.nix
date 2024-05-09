_inputs: {
  config,
  lib,
  ...
}:
with lib; let
  dunstOpacity = toHexString ((builtins.ceil (libx.cfg.theme.transparency * 100)) * 255 / 100);
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.dunst.enable {
    services.dunst = {
      enable = true;
      settings = with libx.cfg.theme.base16.withHashtag; {
        global = {
          separator_color = base02;
          font = with libx.cfg.theme.font; "${sansserif.name} ${toString size.gui}";
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
