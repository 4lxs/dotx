{
  self,
  end4,
  ags,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.ags.end4.enable {
    programs.ags = {
      enable = true;
      # configDir = end4 + "/.config/ags";
      extraPackages = with pkgs; [
        gtksourceview
      ];
    };

    # xdg.configFile."ags".source = config.lib.file.mkOutOfStoreSymlink () (end4 + "/.config/ags");

    home.packages = with pkgs; [
      ddcutil # TODO: Error: No /dev/i2c devices exist. ddcutil requires module i2c-dev.
      gradience
      pywal
      ydotool # for on-screen keyboard
      foot # for scripts
      dart-sass
      gnome-usage # for cpu
      hyprpicker # for picker
      slurp # for screenshot
      gojq # for screenshot
      glib # for gsettings
      blueberry # for bluetooth
      gammastep # for blue light filter
      gnome.gnome-control-center # for settings
      (python312.withPackages (p: [
        p.pillow
        p.material-color-utilities
        p.libsass
        p.setproctitle # for keep system awake
        p.pywayland # for keep system awake
        self.packages.${pkgs.system}.materialyoucolor-python
      ]))
    ];
  };
}
