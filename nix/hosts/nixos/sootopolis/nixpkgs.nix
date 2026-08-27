{sharedPackageSets, ...}: {
  flake.nixosModules.sootopolis.nixpkgs.pkgs = sharedPackageSets.x86_64-linux;
}
