{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.nh = inputs.nix-wrapper-modules.wrappers.nh.wrap {
      inherit pkgs;

      flake = "github:alyraffauf/hoenn";
    };
  };

  flake = {
    nixosModules.default = {
      pkgs,
      self,
      ...
    }: {
      environment.systemPackages = [
        pkgs.git
        self.packages.${pkgs.stdenv.hostPlatform.system}.nh
      ];
    };

    darwinModules.default = {
      pkgs,
      self,
      ...
    }: {
      environment.systemPackages = [
        pkgs.git
        self.packages.${pkgs.stdenv.hostPlatform.system}.nh
      ];
    };

    homeModules.aly = {
      pkgs,
      self,
      ...
    }: {
      home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.nh];
    };
  };
}
