{inputs, ...}: {
  flake = {
    homeModules.hermesAgent = {
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

    nixosModules.hermesWebui = {pkgs, ...}: {
      imports = [inputs.hermes-webui.nixosModules.default];

      services.hermes-webui = {
        enable = true;
        group = "aly";
        hermesHome = "/home/aly/.hermes";
        host = "0.0.0.0";
        openFirewall = true;
        port = 8787;
        stateDir = "/home/aly/.hermes/webui";
        user = "aly";

        agent.package =
          inputs.hermes-agent.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
    };
  };
}
