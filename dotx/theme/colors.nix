{ lib, config, ... }:
with lib;
let
  libx = config.lib.dotx;
in
{
  options.dotx.theme = {
    # copied from base16.nix
    base16 =
      with types;
      let
        schemeAttrsType = attrsOf anything;
        optionValueType = oneOf [
          schemeAttrsType
          path
          str
        ];
        coerce = value: if value ? "scheme-name" then value else libx.base16.mkSchemeAttrs value;
      in
      lib.options.mkOption {
        description = "Current scheme (scheme attrs or a path to a yaml file)";
        type = coercedTo optionValueType coerce schemeAttrsType;
      };
  };
}
