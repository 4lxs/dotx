_inputs: {
  config,
  lib,
  ...
}:
with lib; let
  libx = config.lib.dotx;
  inherit
    (libx.cfg.theme.font)
    serif
    sansserif
    monospace
    emoji
    ;
in {
  # TODO: console.font
  config.fonts = mkIf libx.cfg.fontconfig.enable {
    packages = [
      emoji.package
      serif.package
      sansserif.package
      monospace.package
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [emoji.name];
        serif = [serif.name];
        sansSerif = [sansserif.name];
        monospace = [monospace.name];
      };
    };
  };
}
