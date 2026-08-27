_: {
  flake.nixosModules.nixos = {
    services.fstrim.enable = true;
  };
}
