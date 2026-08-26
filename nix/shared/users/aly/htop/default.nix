_: let
  userPackages = {pkgs, ...}: {
    users.users.aly.packages = [pkgs.htop];
  };
in {
  flake = {
    darwinModules.aly = userPackages;

    homeModules.aly = {pkgs, ...}: {
      home.packages = [pkgs.htop];
    };

    nixosModules.aly = userPackages;
  };
}
