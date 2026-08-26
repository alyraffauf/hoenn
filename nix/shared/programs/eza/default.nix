_: {
  flake = let
    packages = {
      pkgs,
      self,
      ...
    }: {
      environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.eza];
    };
  in {
    darwinModules.default = packages;

    homeModules.aly = {
      pkgs,
      self,
      ...
    }: {
      home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.eza];
    };

    nixosModules.default = packages;
  };
}
