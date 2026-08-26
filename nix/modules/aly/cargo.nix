_: let
  userPackages = {pkgs, ...}: {
    users.users.aly.packages = [pkgs.cargo];
  };
in {
  flake = {
    darwinModules.aly = userPackages;

    homeModules.aly = {pkgs, ...}: {
      home.packages = [pkgs.cargo];
    };

    nixosModules.aly = userPackages;
  };
}
