_: let
  userPackages = {pkgs, ...}: {
    users.users.aly.packages = [pkgs.opencode];
  };
in {
  flake = {
    nixosModules.aly = userPackages;
    darwinModules.aly = userPackages;

    homeModules.aly = {
      programs.opencode = {
        enable = true;

        settings = {
          plugin = [
            "opencode-openai-codex-auth"
            "@warp-dot-dev/opencode-warp"
          ];

          small_model = "opencode/big-pickle";

          agent = {
            explore.model = "opencode/big-pickle";
            scout.model = "opencode/big-pickle";
          };
        };

        tui.theme = "catppuccin-frappe";
      };
    };
  };
}
