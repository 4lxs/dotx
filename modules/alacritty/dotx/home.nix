_inputs:
{
  config,
  lib,
  libx,
  pkgs,
  ...
}:
with lib;
let
  noTmuxEntry = pkgs.makeDesktopItem {
    name = "alacritty";
    desktopName = "Alacritty (no tmux)";
    exec = "alacritty -e zsh";
    icon = "Alacritty";
    terminal = false;
  };
in
{
  options.dotx.alacritty = libx.mkTargetOption "alacritty terminal emulator" // {
    openTmux = mkOption {
      type = types.bool;
      default = config.dotx.tmux.makeTerminalDefault;
      description = ''
        make default program tmux and add a desktop entry without tmux for
        special cases
      '';
    };
  };

  config = mkIf config.dotx.alacritty.enable {
    home.packages = if config.dotx.alacritty.openTmux then [ noTmuxEntry ] else [ ];

    programs.alacritty = {
      enable = true;

      settings = {
        scrolling.history = 0;
        # dynamic_title = true;
        env.TERM = "tmux-256color";

        font = with config.dotx.theme.font; {
          normal = {
            family = monospace.name;
            style = "Regular";
          };
          size = size.terminal;
        };

        window = {
          opacity = config.dotx.theme.transparency;
          dynamic_padding = true;
        };

        cursor.style.shape = "Beam";
        shell = mkIf config.dotx.alacritty.openTmux {
          program = "${pkgs.tmux}/bin/tmux";
          args = [
            "new"
            "-AsMain"
          ];
        };

        colors = with config.dotx.theme.base16.withHashtag; {
          primary = {
            foreground = base05;
            background = base00;
            bright_foreground = base07;
          };
          selection = {
            text = base05;
            background = base02;
          };
          cursor = {
            text = base00;
            cursor = base05;
          };
          normal = {
            black = base00;
            white = base05;
            inherit
              red
              green
              yellow
              blue
              magenta
              cyan
              ;
          };
          bright = {
            black = base03;
            white = base07;
            red = bright-red;
            green = bright-green;
            inherit yellow;
            blue = bright-blue;
            magenta = bright-magenta;
            cyan = bright-cyan;
          };
        };
      };
    };
  };
}
