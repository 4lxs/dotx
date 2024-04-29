{ lib, ... }:
with lib;
let
  configs = builtins.attrNames (builtins.readDir ./configs);
in
{
  imports = builtins.map (cfg: ./configs + "/${cfg}") configs;

  options.dotx.config = mkOption { type = types.enum (configs ++ [ "clean" ]); };
}
