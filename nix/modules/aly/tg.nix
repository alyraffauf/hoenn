{inputs, ...}: let
  userPackages = {pkgs, ...}: {
    users.users.aly.packages = [inputs.tg.packages.${pkgs.stdenv.hostPlatform.system}.default];
  };
in {
  flake = {
    nixosModules.aly = userPackages;
    darwinModules.aly = userPackages;

    homeModules.aly = {pkgs, ...}: {
      home.packages = [inputs.tg.packages.${pkgs.stdenv.hostPlatform.system}.default];
    };
  };
}
