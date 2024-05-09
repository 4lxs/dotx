_inputs: {
  config,
  lib,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  options.dotx.mako = libx.mkTargetOption "mako notification daemon";

  config = mkIf config.dotx.mako.enable {
    services.mako = {
      enable = true;
      font = with config.dotx.theme.font; sansserif.name + " " + (toString size.gui);
      padding = "15";
      defaultTimeout = 5000;
      borderSize = 2;
      borderRadius = 5;
      backgroundColor = "#1e1e2e";
      borderColor = "#b4befe";
      progressColor = "over #313244";
      textColor = "#cdd6f4";
      icons = true;
      actions = true;
      extraConfig = ''
        text-alignment=center
        [urgency=high]
        border-color=#fab387
      '';
    };
  };
}
