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
        font = {
          normal = mkDefault {
            name = "FiraCode Nerd Font";
            package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
          };
          monospace = mkDefault {
            name = "FiraCode Nerd Font Mono";
            package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
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

      hyprland.enable = true;
      dunst.enable = true;
      tmux.enable = true;
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
