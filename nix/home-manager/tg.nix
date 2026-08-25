{inputs, ...}: {
  flake.homeModules.aly = {pkgs, ...}: {
    home.packages = [inputs.tg.packages.${pkgs.stdenv.hostPlatform.system}.default];
  };
}
