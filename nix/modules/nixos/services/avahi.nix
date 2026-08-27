_: {
  flake.nixosModules.nixos = {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;

      publish = {
        enable = true;
        userServices = true;
        workstation = true;
      };
    };
  };
}
