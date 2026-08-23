_: {
  flake.nixosModules.petalburg = {self, ...}: {
    home-manager.users.aly = {
      imports = [self.homeModules.syncthing];

      hoenn.syncthing = {
        enable = true;

        folders = {
          roms.enable = true;
          sync.enable = true;
        };
      };
    };
  };
}
