_: let
  userPackages = {pkgs, ...}: {
    users.users.aly.packages = [pkgs.lazygit];
  };
in {
  flake = {
    nixosModules.aly = userPackages;
    darwinModules.aly = userPackages;

    homeModules.aly = {
      programs.lazygit.enable = true;
    };
  };
}
