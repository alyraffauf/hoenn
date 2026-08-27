_: {
  flake.homeModules.ghostty = {
    pkgs,
    lib,
    ...
  }: {
    programs.ghostty = {
      enable = true;
      package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin pkgs.ghostty-bin;

      settings =
        {
          theme = "Catppuccin Frappe";
          notify-on-command-finish = "unfocused";
          tab-inherit-working-directory = false;
          window-inherit-working-directory = false;
          font-family = "CaskaydiaCove Nerd Font";
        }
        // lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
          gtk-titlebar-style = "tabs";
          window-theme = "dark";
          linux-cgroup = "always";
        };
    };
  };
}
