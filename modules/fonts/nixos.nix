{
  config,
  lib,
  libx,
  ...
}:
with lib;
with config.dotx.theme.font;
{
  options.dotx.fontconfig.enable = libx.mkEnableTarget "fontconfig";
  # TODO: console.font

  config.fonts = builtins.trace "yay" (
    mkIf config.dotx.fontconfig.enable {
      packages = [
        emoji.name
        serif.name
        sansserif.name
        monospace.name
      ];
      fontconfig = {
        enable = true;
        defaultFonts = {
          emoji = [ emoji.name ];
          serif = [ serif.name ];
          sansSerif = [ sansserif.name ];
          monospace = [ monospace.name ];
        };
      };
    }
  );
}
