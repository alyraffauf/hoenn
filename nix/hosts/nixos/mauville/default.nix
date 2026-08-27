{
  inputs,
  self,
  ...
}: {
  config = {
    flake.nixosConfigurations.mauville = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        inputs.determinate.nixosModules.default
        inputs.disko.nixosModules.disko
        inputs.sops-nix.nixosModules.sops
        self.nixosModules.default
        self.nixosModules.nixos
        self.nixosModules.mauville
        self.nixosModules.aly
        self.nixosModules.gnome
        self.nixosModules.homebrew
        self.nixosModules.tailscale
        self.nixosModules.wireguardHoenn
        self.nixosModules.zen
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
