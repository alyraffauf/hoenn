_: let
  userPackages = {pkgs, ...}: {
    users.users.aly.packages = [pkgs.herdr];
  };
in {
  flake = {
    nixosModules.aly = userPackages;
    darwinModules.aly = userPackages;

    homeModules.aly = {
      programs.herdr.enable = true;
    };
  };
}
