{inputs, ...}: {
  flake = {
    nixosModules.zen = {pkgs, ...}: let
      zen = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped.overrideAttrs (old: {
        passthru =
          (old.passthru or {})
          // {
            # Nixpkgs renamed ffmpegSupport; remove once the Zen flake follows suit.
            withFFmpeg = true;
          };
      });
    in {
      environment.systemPackages = [
        (pkgs.wrapFirefox zen {
          extraPolicies.ExtensionSettings."{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "normal_installed";
          };
        })
      ];
    };

    darwinModules.zen = {
      homebrew.casks = ["zen"];
    };
  };
}
