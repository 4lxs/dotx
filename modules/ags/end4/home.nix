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

    xdg.configFile."ags" = {
      source = end4 + "/.config/ags";
      recursive = true;
      executable = true;
    };

    home.packages = with pkgs; [
      ddcutil # TODO: Error: No /dev/i2c devices exist. ddcutil requires module i2c-dev.
      brightnessctl
      gradience
      fuzzel
      pywal
      hyprpicker
      ydotool # for on-screen keyboard
      foot # for scripts
      dart-sass
      gnome-usage # for cpu
      hyprpicker # for picker
      slurp # for screenshot
      gojq # for screenshot
      glib # for gsettings
      blueberry # for bluetooth
      gnome.gnome-bluetooth
      gammastep # for blue light filter
      gnome.gnome-control-center # for settings
      (python312.withPackages (p: [
        p.pillow
        p.material-color-utilities
        p.libsass
        p.setproctitle # for keep system awake
        p.pywayland # for keep system awake
        p.psutil
        self.packages.${pkgs.system}.materialyoucolor-python
      ]))
    ];
  };
}
