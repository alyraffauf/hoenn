{
  inputs,
  self,
  sharedPackageSets,
  ...
}: {
  config.flake.nixosConfigurations.fallarbor = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      {
        nixpkgs.pkgs = sharedPackageSets.x86_64-linux;
      }

      inputs.determinate.nixosModules.default
      inputs.disko.nixosModules.disko
      self.nixosModules.cosmic
      self.nixosModules.default
      self.nixosModules.dustin
      self.nixosModules.fallarbor
      self.nixosModules.thermald
      self.nixosModules.wireguardHoenn
    ];

    specialArgs = {inherit self;};
  };
}
