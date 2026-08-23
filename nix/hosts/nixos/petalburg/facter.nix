_: {
  flake.nixosModules.petalburg = {self, ...}: {
    hardware.facter.reportPath = self + "/nix/hosts/nixos/petalburg/facter.json";
  };
}
