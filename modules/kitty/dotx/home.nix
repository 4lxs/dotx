_inputs:
{ config, lib, ... }:
with lib;
let
  libx = config.lib.dotx;
  theme = config.dotx.theme.base16 {
    templateRepo = libx.templates.kitty;
    target = "default-256";
  };
in
{
  options.dotx.kitty = libx.mkTargetOption "kitty terminal emulator";

  config = mkIf config.dotx.kitty.enable {
    programs.kitty = {
      enable = true;

      font = with config.dotx.theme.font; {
        inherit (monospace) name package;
        size = size.terminal;
      };
      settings.background_opacity = builtins.toString config.dotx.theme.transparency;
      extraConfig = ''
        include ${theme}
      '';
    };
  };
}
