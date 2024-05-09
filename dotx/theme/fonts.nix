{lib, ...}:
with lib; let
  mkFontOption = desc:
    mkOption {
      type = with types;
        submodule {
          options = {
            name = mkOption {type = str;};
            package = mkOption {type = package;};
          };
        };
    };
in {
  options.dotx.theme.font = {
    size = {
      terminal = mkOption {
        type = types.int;
        description = "font size for terminal";
      };
      gui = mkOption {
        type = types.int;
        description = "font size for gui";
      };
    };
    emoji = mkFontOption ''
      font used for emoji
    '';
    serif = mkFontOption ''
      not used currently
    '';
    sansserif = mkFontOption ''
      font used for most gui text
    '';
    monospace = mkFontOption ''
      font used for terminal and code
    '';
  };
}
