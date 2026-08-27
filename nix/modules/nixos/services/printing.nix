_: {
  flake.nixosModules.nixos = {
    programs.system-config-printer.enable = true;
    services.printing.enable = true;
  };
}
