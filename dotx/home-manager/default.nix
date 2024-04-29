inputs:
{ lib, ... }:
let
  modules = import ../importModules.nix { inherit lib; } "home";
in
{
  imports = [
    ../dotx.nix

    inputs.ags.homeManagerModules.default
  ] ++ modules;
}
