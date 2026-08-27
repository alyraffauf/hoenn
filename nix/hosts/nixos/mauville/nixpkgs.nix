{sharedPackageSets, ...}: {
  flake.nixosModules.mauville.nixpkgs.pkgs = sharedPackageSets.x86_64-linux;
}
