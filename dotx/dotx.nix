{
  options,
  lib,
  ...
}:
with lib; let
  configs = builtins.attrNames options.dotx.configs;
in {
  imports = [./theme ./modules.nix];
  options.dotx = {
    config = mkOption {type = types.enum (configs ++ ["clean"]);};
  };
}
