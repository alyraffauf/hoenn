{inputs, ...}: let
  neovimPackage = pkgs: inputs.eevee.packages.${pkgs.stdenv.hostPlatform.system}.sylveon;
  userPackages = {pkgs, ...}: {
    users.users.aly.packages = [(neovimPackage pkgs)];
  };
in {
  flake = {
    homeModules.aly = {pkgs, ...}: {
      home.packages = [(neovimPackage pkgs)];
    };

    darwinModules.aly = userPackages;
    nixosModules.aly = userPackages;
  };
}
