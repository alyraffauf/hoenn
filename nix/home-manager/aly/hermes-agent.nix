{inputs, ...}: {
  flake.homeModules.alyHermesAgent = {
    imports = [inputs.hermes-agent.homeManagerModules.default];

    programs.hermes-agent.enable = true;

    services.hermes-agent = {
      enable = true;
      gateway.enable = true;

      backend = {
        mode = "dashboard";
        port = 9119;
      };
    };
  };
}
