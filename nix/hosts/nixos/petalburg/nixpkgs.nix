{sharedPackageSets, ...}: {
  flake.nixosModules.petalburg.nixpkgs.pkgs = sharedPackageSets.x86_64-linux;
}
