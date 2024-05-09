{
  options,
  lib,
  ...
}:
with lib; let
  configs = builtins.attrNames options.dotx.configs;
in {
  imports = [./options];
  options.dotx = {
    config = mkOption {type = types.enum (configs ++ ["clean"]);};
  };
}
