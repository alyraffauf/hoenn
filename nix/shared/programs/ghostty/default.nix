_: {
  flake = {
    darwinModules.default = {
      pkgs,
      self,
      ...
    }: {
      environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.ghostty];
    };

    homeModules.alyGhostty = {
      pkgs,
      self,
      ...
    }: {
      home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.ghostty];
    };

    nixosModules.aly = {
      pkgs,
      self,
      ...
    }: {
      users.users.aly.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.ghostty];
    };

    systemModules.default = {
      inputs,
      pkgs,
      ...
    }: {
      environment.systemPackages = [inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.ghostty];
    };
  };
}
