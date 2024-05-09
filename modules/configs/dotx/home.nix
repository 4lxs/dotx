_inputs: {
  config,
  lib,
  pkgs,
  ...
}: let
  libx = config.lib.dotx;
in
  with lib; {
    options.dotx.configs.dotx = libx.mkConfigOption "dotx" ''
      the default dotx configuration
    '';

    config = mkIf config.dotx.configs.dotx.enable {
      dotx = {
        theme = {
          font = rec {
            sansserif = mkDefault {
              name = "FiraCode Nerd Font";
              package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
            };
            serif = sansserif; # not used currently anyways
            monospace = mkDefault {
              name = "FiraCode Nerd Font Mono";
              package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
            };
            emoji = mkDefault {
              name = "Noto Color Emoji";
              package = pkgs.noto-fonts-color-emoji;
            };
            size = {
              terminal = mkDefault 12;
              gui = mkDefault 12;
            };
          };
          base16 = mkDefault (
            libx.base16.mkSchemeAttrs "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml"
          );
          darkTheme = mkDefault true;
          transparency = 0.95;
          wallpaper = ./wallpaper.jpg;
        };

        zathura.enable = true;
        fontconfig.enable = true;
        hyprland.enable = true;
        tmux = {
          enable = true;
          makeTerminalDefault = true;
        };
        kitty.enable = true;
        alacritty.enable = true;
        ags.enable = true;
        fish.enable = true;
        rofi.enable = true;
        kde.enable = true;
        gtk.enable = true;
        starship.enable = true;
        shell-help.enable = true;
        kdeconnect.enable = true;
      };
    };
  }
