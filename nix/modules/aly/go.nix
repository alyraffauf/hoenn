_: let
  userPackages = {pkgs, ...}: {
    users.users.aly.packages = [pkgs.go];
  };
in {
  flake = {
    darwinModules.aly = userPackages;

    homeModules.aly = {pkgs, ...}: {
      home.packages = [pkgs.go];
    };

    nixosModules.aly = userPackages;
  };
}
