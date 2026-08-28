{inputs, ...}: {
  flake = {
    homeModules.hermesAgent = {
      config,
      self,
      ...
    }: {
      imports = [
        inputs.hermes-agent.homeManagerModules.default
        inputs.sops-nix.homeManagerModules.sops
      ];

      sops = {
        age.keyFile = "/home/aly/.config/sops/age/keys.txt";

        secrets.hermes = {
          key = "env";
          sopsFile = self + "/secrets/hermes.yaml";
        };
      };

      programs.hermes-agent.enable = true;

      services.hermes-agent = {
        enable = true;
        environmentFiles = [config.sops.secrets.hermes.path];
        gateway.enable = true;

        backend = {
          mode = "dashboard";
          port = 9119;
        };

        settings = {
          browser.cloud_provider = "browserbase";
          display.interface = "tui";
          stt = {
            enabled = true;
            local.model = "base";
            openai.model = "whisper-1";
            provider = "openai";
          };
          tts = {
            elevenlabs = {
              model_id = "eleven_flash_v2_5";
              voice_id = "EST9Ui6982FZPSi7gCHi";
            };
            provider = "elevenlabs";
          };
          web.backend = "firecrawl";
        };
      };
    };

    nixosModules.hermesWebui = {pkgs, ...}: {
      imports = [inputs.hermes-webui.nixosModules.default];

      services.hermes-webui = {
        enable = true;
        group = "aly";
        hermesHome = "/home/aly/.hermes";
        stateDir = "/home/aly/.hermes/webui";
        user = "aly";

        agent.package =
          inputs.hermes-agent.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
    };
  };
}
