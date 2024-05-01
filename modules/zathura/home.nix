{
  config,
  lib,
  libx,
  ...
}:
with lib;
{
  options.dotx.zathura.enable = libx.mkEnableTarget "zathura document viewer";

  config = mkIf config.dotx.zathura.enable {
    programs.zathura = {
      enable = true;
      options = with config.dotx.theme.base16.withHashtag; {
        # adjust-open = "best-fit";
        # pages-per-row = 1;

        # scroll-page-aware = true;
        # scroll-step = 100;

        default-bg = base00;
        default-fg = base01;
        statusbar-fg = base04;
        statusbar-bg = base02;
        inputbar-bg = base00;
        inputbar-fg = base07;
        notification-bg = base00;
        notification-fg = base07;
        notification-error-bg = base00;
        notification-error-fg = base08;
        notification-warning-bg = base00;
        notification-warning-fg = base08;
        highlight-color = base0A;
        highlight-active-color = base0D;
        completion-bg = base01;
        completion-fg = base0D;
        completion-highlight-fg = base07;
        completion-highlight-bg = base0D;
        recolor-lightcolor = base00;
        recolor-darkcolor = base06;

        # default-bg = "#1a1b26";
        # default-fg = "#a9b1d6";
        #
        # statusbar-fg = "#a9b1d6";
        # statusbar-bg = "#24283b";
        #
        # inputbar-bg = "#1a1b26";
        # inputbar-fg = "#73daca";
        #
        # notification-bg = "#1a1b26";
        # notification-fg = "#73daca";
        #
        # notification-error-bg = "#1a1b26";
        # notification-error-fg = "#f7768e";
        #
        # notification-warning-bg = "#1a1b26";
        # notification-warning-fg = "#f7768e";
        #
        # highlight-color = "#e0af68";
        # highlight-active-color = "#9aa5ce";
        #
        # completion-bg = "#24283b";
        # completion-fg = "#a9b1d6";
        #
        # completion-highlight-fg = "#9aa5ce";
        # completion-highlight-bg = "24283b";
        #
        # recolor-lightcolor = "#16161e";
        # recolor-darkcolor = "#a9b1d6";
        #
        recolor = "true";
        # recolor-keephue = "true";

        selection-clipboard = "clipboard";
      };
    };
    xdg.mimeApps.defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
    };
  };
}
