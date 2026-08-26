_: {
  flake.homeModules.aly = {
    pkgs,
    self,
    ...
  }: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.git];
  };
}
