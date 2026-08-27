_: {
  flake.nixosModules.nixos = {
    services.tuned = {
      enable = true;
      ppdSupport = true;
      settings.dynamic_tuning = true;
    };
  };
}
