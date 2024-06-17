_inputs: {
  config,
  lib,
  pkgs,
  ...
}: let
  libx = config.lib.dotx;
in
  with lib; {
    config = mkIf libx.cfg.configs.end4.enable {
      dotx = {
        ags.end4.enable = true;

        # not part of end4, but makes things better
        gtk.enable = true;
        kde.enable = true;
        fontconfig.enable = true;

        # FIXME: placeholders

        editor = "nvim";

        theme = {
          font = rec {
            sansserif = mkDefault {
              name = "FiraCode Nerd Font";
              package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
            };
            serif = sansserif; # not used currently anyways
            monospace = mkDefault {
              name = "FiraCode Nerd Font Mono";
              package = pkgs.nerdfonts.override {fonts = ["FiraMono"];};
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
      };
    };
  }
