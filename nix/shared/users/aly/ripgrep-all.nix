_: let
  module = {pkgs, ...}: {
    environment.systemPackages = [pkgs.ripgrep-all];
  };
in {
  flake = {
    darwinModules.default = module;

    homeModules.aly = {pkgs, ...}: {
      home.packages = [pkgs.ripgrep-all];
    };

    nixosModules.default = module;
  };
}
