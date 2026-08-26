_: {
  flake = let
    userPackages = {
      pkgs,
      self,
      ...
    }: {
      users.users.aly.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.eza];
    };
  in {
    darwinModules.aly = userPackages;

    homeModules.aly = {
      pkgs,
      self,
      ...
    }: {
      home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.eza];
    };

    nixosModules.aly = userPackages;
  };
}
