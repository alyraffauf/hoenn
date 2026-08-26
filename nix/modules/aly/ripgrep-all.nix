_: let
  userPackages = {pkgs, ...}: {
    users.users.aly.packages = [pkgs.ripgrep-all];
  };
in {
  flake = {
    darwinModules.aly = userPackages;

    homeModules.aly = {pkgs, ...}: {
      home.packages = [pkgs.ripgrep-all];
    };

    nixosModules.aly = userPackages;
  };
}
