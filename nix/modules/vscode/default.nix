_: {
  flake.homeModules.vscode = {pkgs, ...}: {
    home.packages = [pkgs.vscode];
  };
}
