{inputs, ...}: let
  neovimPackage = pkgs: inputs.eevee.packages.${pkgs.stdenv.hostPlatform.system}.sylveon;
in {
  flake.homeModules.aly = {pkgs, ...}: {
    home.packages = [(neovimPackage pkgs)];
  };
}
