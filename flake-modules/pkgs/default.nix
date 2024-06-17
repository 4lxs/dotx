{inputs, ...}: {
  perSystem = {
    inputs',
    pkgs,
    ...
  }: {
    packages = {
      materialyoucolor-python = pkgs.callPackage ./materialyoucolor-python.nix {};
      # aylur's ags package is x86_64-linux only
      asztal = pkgs.callPackage (inputs.aylur + "/ags") {inherit inputs;};
    };
  };
}
