{
  perSystem = {pkgs, ...}: {
    packages = {
      materialyoucolor-python = pkgs.callPackage ./materialyoucolor-python.nix {};
    };
  };
}
