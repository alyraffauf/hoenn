_: {
  flake.homeModules.opencodeDesktop = {pkgs, ...}: {
    home.packages = [pkgs.opencode-desktop];
  };
}
