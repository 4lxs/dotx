{
  config,
  pkgs,
  lib,
  libx,
  ...
}:
with lib;
{
  config.dotx.theme = mkIf (config.dotx.theme.fallback == "svl") {
    font = mkDefault {
      name = "FiraCode Nerd Font Mono";
      package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
    };
    base16 = mkDefault (
      libx.base16.mkSchemeAttrs "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml"
    );
    darkTheme = mkDefault true;
  };
}
