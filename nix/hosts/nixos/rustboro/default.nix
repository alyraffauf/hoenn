{
  inputs,
  self,
  ...
}: {
  config.flake.nixosConfigurations.rustboro = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      inputs.determinate.nixosModules.default
      inputs.disko.nixosModules.disko
      inputs.sops-nix.nixosModules.sops
      self.nixosModules.aly
      self.nixosModules.default
      self.nixosModules.google-chrome
      self.nixosModules.homebrew
      self.nixosModules.niri
      self.nixosModules.nixos
      self.nixosModules.rustboro
      self.nixosModules.sway
      self.nixosModules.tailscale
      self.nixosModules.thermald
      self.nixosModules.wireguardHoenn
      self.nixosModules.zen
    ];

    specialArgs = {inherit self;};
  };
}
