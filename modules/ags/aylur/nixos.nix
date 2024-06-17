{aylur, ...}: {
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs;
  with gnome; [
    morewaita-icon-theme
    adwaita-icon-theme
    qogir-icon-theme
  ];
  # services.greetd = {
  #   enable = true;
  #   settings.default_session.command = "${asztal}/bin/greeter";
  # };
}
