{sharedPackageSets, ...}: {
  flake.nixosModules.fallarbor.nixpkgs.pkgs = sharedPackageSets.x86_64-linux;
}
