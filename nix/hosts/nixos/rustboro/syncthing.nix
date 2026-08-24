_: {
  flake.nixosModules.rustboro = {
    config,
    self,
    ...
  }: let
    syncthingCert = config.sops.secrets.syncthing-cert.path;
    syncthingKey = config.sops.secrets.syncthing-key.path;
  in {
    sops.secrets = {
      syncthing-cert = {
        sopsFile = self + "/secrets/syncthing-rustboro.yaml";
        key = "cert";
        owner = "aly";
      };

      syncthing-key = {
        sopsFile = self + "/secrets/syncthing-rustboro.yaml";
        key = "key";
        owner = "aly";
      };
    };

    home-manager.users.aly = {
      imports = [self.homeModules.alySyncthing];

      hoenn.syncthing = {
        enable = true;
        cert = syncthingCert;
        key = syncthingKey;

        folders.sync.enable = true;
      };
    };
  };
}
