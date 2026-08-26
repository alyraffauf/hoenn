_: let
  userPackages = {pkgs, ...}: {
    users.users.aly.packages = [pkgs.nodejs];
  };
in {
  flake = {
    nixosModules.aly = userPackages;
    darwinModules.aly = userPackages;

    homeModules.aly = {
      programs.npm.enable = true;
    };
  };
}
