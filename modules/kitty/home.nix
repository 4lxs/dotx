{
  config,
  lib,
  libx,
  ...
}:
with lib;
let
  theme = config.dotx.theme.base16 {
    templateRepo = libx.templates.kitty;
    target = "default-256";
  };
in
{
  options.dotx.kitty.enable = libx.mkEnableTarget "kitty terminal emulator";

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
