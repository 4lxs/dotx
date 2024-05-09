{lib, ...}:
with lib; {
  imports = [
    ./colors.nix
    ./fonts.nix
  ];

  options.dotx.theme = {
    darkTheme = mkOption {
      type = types.bool;
      description = "use dark theme";
    };
    transparency = mkOption {
      type = types.oneOf [
        # (types.enum [ false ])
        (types.numbers.between 0 1)
      ];
      description = ''
        the opacity of some windows. which windows will be transparent is
        dependent on the config, but this value can be used to adjust or disable
        it. 0 is fully transparent, 100 is fully opaque, false disables transparency.
      '';
    };
    wallpaper = mkOption {
      type = with types; coercedTo package toString path;
      description = "wallpaper image";
    };
  };
}
