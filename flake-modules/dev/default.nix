{...}: {
  imports = [
    ./devshell.nix
    ./pre-commit.nix
  ];

  perSystem = {pkgs, ...}: {
    formatter = pkgs.alejandra;
  };
}
