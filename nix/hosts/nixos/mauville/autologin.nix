_: {
  flake.nixosModules.mauville = {
    services.displayManager.autoLogin = {
      enable = true;
      user = "aly";
    };
  };
}
