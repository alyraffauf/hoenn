{sharedPackageSets, ...}: {
  flake.nixosModules.rustboro.nixpkgs.pkgs = sharedPackageSets.x86_64-linux;
}
