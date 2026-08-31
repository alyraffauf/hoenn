{
  inputs,
  lib,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages = lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
      mango = inputs.nix-wrapper-modules.lib.wrapPackage (
        {
          config,
          lib,
          ...
        }: {
          inherit pkgs;

          package = pkgs.mango;

          constructFiles.generatedConfig = {
            relPath = "${config.binName}-config.conf";
            content = builtins.readFile ./config.conf;
          };

          addFlag = [
            [
              "-c"
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
            ${lib.getExe pkgs.mango} -c ${config.constructFiles.generatedConfig.path} -p
            runHook postInstall
          '';

          filesToPatch = ["share/wayland-sessions/*.desktop"];

          passthru.providedSessions = pkgs.mango.passthru.providedSessions;
        }
      );
    };
  };
}
