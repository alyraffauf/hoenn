_: let
  userPackages = {pkgs, ...}: {
    users.users.aly.packages = [pkgs.gh];
  };
in {
  flake = {
    nixosModules.aly = userPackages;
    darwinModules.aly = userPackages;

    homeModules.aly = {
      programs.gh.enable = true;
    };
  };
}
