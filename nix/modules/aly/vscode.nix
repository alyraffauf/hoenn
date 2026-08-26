_: {
  flake = let
    userPackages = {pkgs, ...}: {
      users.users.aly.packages = [pkgs.vscode];
    };
  in {
    darwinModules.aly = userPackages;
    nixosModules.aly = userPackages;
  };
}
