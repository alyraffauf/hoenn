{
  inputs,
  self,
  sharedPackageSets,
  ...
}: {
  config.flake.nixosConfigurations.sootopolis = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      {
        nixpkgs.pkgs = sharedPackageSets.x86_64-linux;
      }

      inputs.determinate.nixosModules.default
      inputs.disko.nixosModules.disko
      self.nixosModules.default
      self.nixosModules.sootopolis
      self.nixosModules.aly
      self.nixosModules.ghostty
      self.nixosModules.niri
      self.nixosModules.tailscale
      self.nixosModules.thermald
      self.nixosModules.wireguardHoenn
    ];

    specialArgs = {inherit self;};
  };
}
