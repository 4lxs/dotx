_inputs: {
  config,
  lib,
  ...
}:
with lib; let
  libx = config.lib.dotx;
  theme = libx.cfg.theme.base16 {
    templateRepo = libx.templates.kitty;
    target = "default-256";
  };
in {
  config = mkIf libx.cfg.kitty.enable {
    programs.kitty = {
      enable = true;

      font = with libx.cfg.theme.font; {
        inherit (monospace) name package;
        size = size.terminal;
      };
      settings.background_opacity = builtins.toString libx.cfg.theme.transparency;
      extraConfig = ''
        include ${theme}
      '';
    };
  };
}
