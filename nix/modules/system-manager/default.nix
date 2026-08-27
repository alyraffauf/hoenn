{lib, ...}: {
  options.flake.systemModules.systemManager = lib.mkOption {
    type = lib.types.deferredModule;
    default = {};
  };
}
