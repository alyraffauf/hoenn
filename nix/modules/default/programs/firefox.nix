_: {
  flake = {
    darwinModules.default = {pkgs, ...}: {
      environment.systemPackages = [pkgs.firefox];
    };

    nixosModules.default = {
      programs.firefox.enable = true;
    };
  };
}
