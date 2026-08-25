{
  inputs,
  lib,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.ghostty = inputs.nix-wrapper-modules.wrappers.ghostty.wrap {
      inherit pkgs;

      settings =
        {
          theme = "Catppuccin Frappe";
          notify-on-command-finish = "unfocused";
          tab-inherit-working-directory = false;
          window-inherit-working-directory = false;
          font-family = "CaskaydiaCove Nerd Font";
        }
        // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
          gtk-titlebar-style = "tabs";
          window-theme = "dark";
          linux-cgroup = "always";
        };
    };
  };
}
