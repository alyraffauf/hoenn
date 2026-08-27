{inputs, ...}: let
  tmuxPackage = pkgs: inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.tmux;

  programs = {pkgs, ...}: {
    programs.tmux = {
      enable = true;
      package = tmuxPackage pkgs;
    };
  };
in {
  flake.homeModules.aly = programs;
}
