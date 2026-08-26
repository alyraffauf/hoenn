{
  lib,
  self,
  sharedPackageSets,
  inputs,
  ...
}: {
  options.flake.darwinModules.fortree = lib.mkOption {
    type = lib.types.deferredModule;
    default = {};
  };

  config.flake = {
    darwinConfigurations.fortree = inputs.nix-darwin.lib.darwinSystem {
      modules = [
        {
          nixpkgs = {
            hostPlatform = "aarch64-darwin";
            pkgs = sharedPackageSets.aarch64-darwin;
          };

          system.primaryUser = "aly";
        }

        self.darwinModules.default
        self.darwinModules.homebrew
        self.darwinModules.aly
        self.darwinModules.ghostty
        self.darwinModules.fortree
        self.darwinModules.tailscale
        self.darwinModules.wireguardHoenn
      ];

      specialArgs = {inherit self;};
    };
  };
}
