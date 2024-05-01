{
  config,
  lib,
  libx,
  pkgs,
  ...
}:
with lib;
{
  config = mkIf (config.dotx.config == "svl") {
    dotx = {
      theme = {
        font = rec {
          sansserif = mkDefault {
            name = "FiraCode Nerd Font";
            package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
          };
          serif = sansserif; # not used currently anyways
          monospace = mkDefault {
            name = "FiraCode Nerd Font Mono";
            package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
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

      fontconfig.enable = true;
      hyprland.enable = true;
      dunst.enable = true;
      tmux = {
        enable = true;
        makeTerminalDefault = true;
      };
      kitty.enable = true;
      alacritty.enable = true;
      waybar.enable = true;
      fish.enable = true;
      rofi.enable = true;
      kde.enable = true;
      gtk.enable = true;
      starship.enable = true;
      shell-help.enable = true;
    };
  };
}
