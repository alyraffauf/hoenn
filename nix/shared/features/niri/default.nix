_: {
  flake = {
    nixosModules.niri = {
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
        pkgs.xwayland-satellite
      ];

      programs = {
        niri = {
          enable = true;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
          useNautilus = true;
        };

        noctalia = {
          enable = true;
          recommendedServices.enable = true;
          systemd.enable = true;
        };
      };

      services = {
        displayManager.noctalia-greeter = {
          enable = true;
          settings.session.default = "Niri";
        };

        gvfs.enable = true;
        iio-niri.enable = true;
      };

      xdg.icons.fallbackCursorThemes = ["Adwaita"];
    };

    homeModules.niri = {
      pkgs,
      self,
      ...
    }: {
      wayland.windowManager.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
      };
    };
  };
}
