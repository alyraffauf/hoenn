{sharedPackageSets, ...}: {
  flake.darwinModules.fortree.nixpkgs = {
    hostPlatform = "aarch64-darwin";
    pkgs = sharedPackageSets.aarch64-darwin;
  };
}
