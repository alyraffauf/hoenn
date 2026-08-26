_: let
  userPackages = {pkgs, ...}: {
    users.users.aly.packages = [pkgs.bun];
  };
in {
  flake = {
    nixosModules.aly = userPackages;
    darwinModules.aly = userPackages;

    homeModules.aly = {
      programs.bun.enable = true;
    };
  };
}
