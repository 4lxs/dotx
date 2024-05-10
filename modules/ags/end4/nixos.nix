_inputs: {
  config,
  pkgs,
  lib,
  ...
}: let
  libx = config.lib.dotx;
in {
  config = lib.mkIf libx.cfg.ags.end4.enable {
    fonts.packages = with pkgs; [
      google-fonts # ttf-readex-pro
      # ttf-jetbrains-mono-nerd
      # ttf-space-mono-nerd
      (pkgs.nerdfonts.override
        {fonts = ["JetBrainsMono" "SpaceMono"];})
      material-symbols # ttf-material-symbols-variable-git
    ];
  };
}
