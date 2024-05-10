{config, ...}: let
  libx = config.lib.dotx;
in
  with libx.options; {
    options.dotx = {
      ags = {
        aylur = mkTarget ''
          ags widgets from [aylur's dotfiles](https://github.com/Aylur/dotfiles)
        '';

        end4 = mkTarget ''
          ags widgets from [end4/dots-hyprland](https://github.com/end-4/dots-hyprland)
        '';
      };

      zathura = mkTarget "zathura document viewer";

      alacritty =
        mkTarget "alacritty terminal emulator"
        // {
          openTmux = mkBool libx.cfg.tmux.makeTerminalDefault ''
            make default program tmux and add a desktop entry without tmux for
            special cases
          '';
        };

      configs.dotx = mkConfig "dotx" ''
        the default dotx configuration
      '';

      dunst = mkTarget "dunst notification daemon";

      fish = mkTarget "fish shell";

      fontconfig = mkTarget ''fonts configuration'';

      gtk = mkTarget "gtk theming";

      hyprland = mkTarget "hyprland window manager";

      kde = mkTarget "kde theming";

      kdeconnect = mkTarget "kdeconnect";

      kitty = mkTarget "kitty terminal emulator";

      mako = mkTarget "mako notification daemon";

      rofi = mkTarget "rofi";

      shell-help =
        mkTarget "helpful shell aliases"
        // {
          git = mkBool libx.cfg.shell-help.enable ''
            helpful git aliases
          '';
        };

      starship = mkTarget "starship prompt";

      tmux =
        mkTarget "tmux"
        // {
          makeTerminalDefault = mkEnable ''
            make terminals open tmux by default and add a special no tmux desktop entry
            for special cases
          '';
        };

      waybar = mkTarget "waybar";
    };
  }
