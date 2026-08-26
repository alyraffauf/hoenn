_: let
  userPackages = {
    pkgs,
    self,
    ...
  }: {
    users.users.aly.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.ghostty];
  };
in {
  flake = {
    darwinModules.aly = userPackages;

    homeModules.aly = {
      pkgs,
      self,
      ...
    }: {
      home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.ghostty];
    };

    nixosModules.aly = userPackages;
  };
}
