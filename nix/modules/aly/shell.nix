_: let
  shellPackages = pkgs:
    with pkgs; [
      age
      duf
      dust
      jq
      just
      yq
    ];
in {
  flake.homeModules.aly = {pkgs, ...}: {
    home.packages = shellPackages pkgs;
  };
}
