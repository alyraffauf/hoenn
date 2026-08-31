{
  inputs,
  lib,
  ...
}: {
  perSystem = {pkgs, ...}: let
    patchedWlroots = pkgs.wlroots_0_20.overrideAttrs (previousAttrs: {
      patches =
        (previousAttrs.patches or [])
        ++ [
          (pkgs.fetchpatch {
            url = "https://github.com/to-json/wlroots-patch/commit/100b64c21b042324299c42da3a3e0a357f5ef464.patch";
            hash = "sha256-w3IDVk83iCPs+a5VzD9lJ+mkOOzRsQIFqPNw9GJNCK8=";
          })
        ];
    });
    patchedSwayUnwrapped = pkgs.sway-unwrapped.override {
      wlroots_0_20 = patchedWlroots;
    };
    patchedSway = pkgs.sway.override {
      sway-unwrapped = patchedSwayUnwrapped;
    };
  in {
    packages = lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
      sway = inputs.nix-wrapper-modules.lib.wrapPackage (
        {
          config,
          lib,
          ...
        }: {
          inherit pkgs;

          package = patchedSway;

          constructFiles.generatedConfig = {
            relPath = "${config.binName}-config";
            content = builtins.readFile ./config;
          };

          addFlag = [
            [
              "--config"
              config.constructFiles.generatedConfig.path
            ]
          ];

          prefixVar = [
            [
              "PATH"
              ":"
              (lib.makeBinPath [pkgs.noctalia])
            ]
          ];

          drv.installPhase = ''
            runHook preInstall
            export XDG_RUNTIME_DIR="$TMPDIR/sway-runtime"
            export WLR_BACKENDS=headless
            export WLR_RENDERER=pixman
            mkdir -m 700 "$XDG_RUNTIME_DIR"
            ${lib.getExe patchedSwayUnwrapped} --validate --config ${config.constructFiles.generatedConfig.path}
            runHook postInstall
          '';

          filesToPatch = [
            "share/applications/*.desktop"
            "share/wayland-sessions/*.desktop"
          ];

          passthru.providedSessions = patchedSway.passthru.providedSessions;
        }
      );
    };
  };
}
