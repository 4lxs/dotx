_inputs: {
  config,
  lib,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.fontconfig.enable {
    # TODO: not useful for nixos as it uses fontconfig.defaultFonts
    fonts.fontconfig.enable = true;
    home.packages = [
      libx.cfg.theme.font.serif.package
      libx.cfg.theme.font.sansserif.package
      libx.cfg.theme.font.monospace.package
      libx.cfg.theme.font.emoji.package
    ];
  };
}
