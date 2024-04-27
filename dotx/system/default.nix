{ lib, ... }:
with lib;
let
  systems = builtins.attrNames (builtins.readDir ./systems);
in
{
  imports = builtins.map (sys: ./systems + "/${sys}") systems;

  options.dotx.system = mkOption { type = types.enum systems; };
}
