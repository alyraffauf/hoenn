_: {
  flake.nixosModules.sway = {
    pkgs,
    self,
    ...
  }: {
    environment.systemPackages = [
      pkgs.adwaita-icon-theme
      pkgs.ddcutil
      pkgs.file-roller
      pkgs.ghostty
      pkgs.gnome-disk-utility
      pkgs.gnome-text-editor
      pkgs.loupe
      pkgs.morewaita-icon-theme
      pkgs.nautilus
      pkgs.vicinae
    ];

    fonts.packages = [pkgs.adwaita-fonts];

    programs = {
      sway = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.sway;
      };

      noctalia = {
        enable = true;
        recommendedServices.enable = true;
        systemd.enable = true;
      };
    };

    services = {
      displayManager.noctalia-greeter.enable = true;
      gvfs.enable = true;
    };

    xdg.icons.fallbackCursorThemes = ["Adwaita"];
  };
}
