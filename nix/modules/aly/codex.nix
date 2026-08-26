_: let
  userPackages = {pkgs, ...}: {
    users.users.aly.packages = [pkgs.codex];
  };
in {
  flake = {
    nixosModules.aly = userPackages;
    darwinModules.aly = userPackages;

    homeModules.aly = {
      programs.codex.enable = true;
    };
  };
}
