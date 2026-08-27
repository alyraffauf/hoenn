_: {
  flake.systemModules.systemManager = {pkgs, ...}: {
    environment.systemPackages = [pkgs.system-manager];
  };
}
