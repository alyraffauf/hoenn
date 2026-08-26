{
  inputs,
  self,
  sharedPackageSets,
  ...
}: {
  config = {
    flake.nixosConfigurations.mauville = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        {
          nixpkgs.pkgs = sharedPackageSets.x86_64-linux;
        }

        inputs.determinate.nixosModules.default
        inputs.disko.nixosModules.disko
        self.nixosModules.default
        self.nixosModules.mauville
        self.nixosModules.aly
        self.nixosModules.ghostty
        self.nixosModules.gnome
        self.nixosModules.tailscale
        self.nixosModules.wireguardHoenn
      ];

      specialArgs = {inherit self;};
    };

    blzrd.nodes.mauville = {
      output = self.nixosConfigurations.mauville.config.system.build.toplevel;
      type = "nixos";
      user = "root";
    };
  };
}
