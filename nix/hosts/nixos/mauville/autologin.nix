_: {
  flake.nixosModules.mauville = {
    config,
    lib,
    ...
  }: {
    services.greetd.settings.initial_session = {
      command = lib.getExe config.programs.sway.package;
      user = "aly";
    };
  };
}
