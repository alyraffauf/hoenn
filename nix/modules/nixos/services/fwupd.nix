_: {
  flake.nixosModules.nixos = {
    services.fwupd.enable = true;
  };
}
