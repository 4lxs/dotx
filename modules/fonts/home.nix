_inputs:
{
  config,
  lib,
  libx,
  ...
}:
with lib;
{
  options.dotx.fontconfig = libx.mkTargetOption ''fonts configuration'';

  config = mkIf config.dotx.fontconfig.enable {
    # TODO: not useful for nixos as it uses fontconfig.defaultFonts
    fonts.fontconfig.enable = true;
    home.packages = [
      config.dotx.theme.font.serif.package
      config.dotx.theme.font.sansserif.package
      config.dotx.theme.font.monospace.package
      config.dotx.theme.font.emoji.package
    ];
  };
}
