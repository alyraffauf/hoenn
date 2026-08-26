{lib, ...}: let
  userPackages = {
    pkgs,
    self,
    ...
  }: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.ghostty];
  };
in {
  options.flake.darwinModules.ghostty = lib.mkOption {
    type = lib.types.deferredModule;
    default = {};
  };

  config.flake = {
    darwinModules.ghostty = userPackages;

    homeModules.ghostty = {
      pkgs,
      self,
      ...
    }: {
      programs.ghostty = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.ghostty;
      };
    };

    nixosModules.ghostty = userPackages;
  };
}
