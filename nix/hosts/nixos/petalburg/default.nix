{
  inputs,
  self,
  ...
}: {
  config = {
    flake.nixosConfigurations.petalburg = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        inputs.determinate.nixosModules.default
        inputs.disko.nixosModules.disko
        inputs.sops-nix.nixosModules.sops
        self.nixosModules.default
        self.nixosModules.petalburg
        self.nixosModules.aly
        self.nixosModules.hermesWebui
        self.nixosModules.niri
        self.nixosModules.tailscale
        self.nixosModules.thermald
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
