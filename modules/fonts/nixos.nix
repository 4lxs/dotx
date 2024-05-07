_inputs:
{ config, lib, ... }:
with lib;
let
  libx = config.lib.dotx;
  inherit (config.dotx.theme.font)
    serif
    sansserif
    monospace
    emoji
    ;
in
{
  options.dotx.fontconfig = libx.mkTargetOption ''
    font configuration
  '';

  # TODO: console.font
  config.fonts = mkIf config.dotx.fontconfig.enable {
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
  };
}
