{inputs, ...}: {
  flake.systemModules.systemManager = {
    imports = [inputs.nix-system-graphics.systemModules.default];

    system-graphics.enable = true;
  };
}
