_: let
  userPackages = {
    pkgs,
    self,
    ...
  }: {
    users.users.aly.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.starship];
  };
in {
  flake = {
    darwinModules.aly = userPackages;
    nixosModules.aly = userPackages;

    homeModules.aly = {
      pkgs,
      self,
      ...
    }: {
      home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.starship];
    };
  };
}
