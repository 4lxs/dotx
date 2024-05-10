{
  pkgs,
  lib,
  ...
}: let
  pypkg = pkgs.python312;
in
  pypkg.pkgs.buildPythonPackage rec {
    pname = "materialyoucolor";
    version = "2.0.9";
    pyproject = true;

    src = pkgs.fetchPypi {
      inherit pname version;
      hash = "sha256-J35//h3tWn20f5ej6OXaw4NKnxung9q7m0E4Zf9PUw4=";
    };

    build-system = [
      pypkg.pkgs.setuptools
    ];

    meta = {
      description = "";
      homepage = "https://github.com/T-Dynamos/materialyoucolor-python";
      license = lib.licenses.mit;
    };
  }
