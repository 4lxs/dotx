{
  config,
  lib,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  options.dotx = {
    ags = libx.mkTargetOption ''
      ags widgets from [aylur's dotfiles](https://github.com/Aylur/dotfiles/tree/main)
    '';

    zathura = libx.mkTargetOption "zathura document viewer";

    alacritty =
      libx.mkTargetOption "alacritty terminal emulator"
      // {
        openTmux = mkOption {
          type = types.bool;
          default = libx.cfg.tmux.makeTerminalDefault;
          description = ''
            make default program tmux and add a desktop entry without tmux for
            special cases
          '';
        };
      };

    configs.dotx = libx.mkConfigOption "dotx" ''
      the default dotx configuration
    '';

    dunst = libx.mkTargetOption "dunst notification daemon";

    fish = libx.mkTargetOption "fish shell";

    fontconfig = libx.mkTargetOption ''fonts configuration'';

    gtk = libx.mkTargetOption "gtk theming";

    hyprland = libx.mkTargetOption "hyprland window manager";

    kde = libx.mkTargetOption "kde theming";

    kdeconnect = libx.mkTargetOption "kdeconnect";

    kitty = libx.mkTargetOption "kitty terminal emulator";

    mako = libx.mkTargetOption "mako notification daemon";

    rofi = libx.mkTargetOption "rofi";

    shell-help =
      libx.mkTargetOption "helpful shell aliases"
      // {
        git = libx.mkBoolOption libx.cfg.shell-help.enable ''
          helpful git aliases
        '';
      };

    starship = libx.mkTargetOption "starship prompt";

    tmux =
      libx.mkTargetOption "tmux"
      // {
        makeTerminalDefault = mkOption {
          type = types.bool;
          description = ''
            make terminals open tmux by default and add a special no tmux desktop entry
            for special cases
          '';
        };
      };

    waybar = libx.mkTargetOption "waybar";
  };
}
