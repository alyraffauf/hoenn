{
  inputs,
  lib,
  ...
}: {
  options.flake.systemModules.default = lib.mkOption {
    type = lib.types.deferredModule;
    default = {};
  };

  config.flake.systemModules.default = {
    _module.args.inputs = inputs;
  };
}
