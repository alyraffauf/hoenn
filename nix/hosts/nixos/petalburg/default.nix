{
  inputs,
  self,
  sharedPackageSets,
  ...
}: {
  config = {
    flake.nixosConfigurations.petalburg = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        {
          nixpkgs.pkgs = sharedPackageSets.x86_64-linux;
        }

        inputs.determinate.nixosModules.default
        inputs.disko.nixosModules.disko
        self.nixosModules.default
        self.nixosModules.petalburg
        self.nixosModules.aly
        self.nixosModules.ghostty
        self.nixosModules.hermesWebui
        self.nixosModules.homebrew
        self.nixosModules.niri
        self.nixosModules.tailscale
        self.nixosModules.wireguardHoenn
      ];

      specialArgs = {inherit self;};
    };

    blzrd.nodes.petalburg = {
      output = self.nixosConfigurations.petalburg.config.system.build.toplevel;
      type = "nixos";
      user = "root";
    };
  };
}
