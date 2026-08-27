{sharedPackageSets, ...}: {
  flake.nixosModules.pacifidlog.nixpkgs.pkgs = sharedPackageSets.x86_64-linux;
}
