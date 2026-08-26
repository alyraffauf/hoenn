{inputs, ...}: let
  tmuxPackage = pkgs: inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.tmux;

  userPackages = {pkgs, ...}: {
    users.users.aly.packages = [(tmuxPackage pkgs)];
  };

  homePackages = {pkgs, ...}: {
    home.packages = [(tmuxPackage pkgs)];
  };
in {
  flake = {
    nixosModules.aly = userPackages;
    darwinModules.aly = userPackages;
    homeModules.aly = homePackages;
  };
}
