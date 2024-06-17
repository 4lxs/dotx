_inputs: {
  config,
  pkgs,
  lib,
  ...
}: let
  libx = config.lib.dotx;
in {
  config = lib.mkIf libx.cfg.ags.end4.enable {
    hardware.i2c.enable = true; # for ddcutil

    security.polkit.enable = true;
    # https://nixos.wiki/wiki/Polkit#Authentication_agents
    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };

    services.upower.enable = true;
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
    };
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    fonts.packages = [
      # TODO: overrides
      pkgs.google-fonts # ttf-readex-pro, rubik

      (pkgs.nerdfonts.override
        {
          fonts = [
            "JetBrainsMono" # ttf-jetbrains-mono-nerd
            "SpaceMono" # ttf-space-mono-nerd
          ];
        })
      pkgs.material-symbols # ttf-material-symbols-variable-git
    ];
  };
}
