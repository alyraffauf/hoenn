_: {
  flake.nixosModules.guix = {
    options,
    pkgs,
    ...
  }: {
    services.guix = {
      enable = true;
      gc.enable = true;

      substituters = {
        urls =
          options.services.guix.substituters.urls.default
          ++ [
            "https://substitutes.nonguix.org"
          ];

        authorizedKeys =
          options.services.guix.substituters.authorizedKeys.default
          ++ [
            (pkgs.writeText "nonguix-signing-key.pub" ''
              (public-key
               (ecc
                (curve Ed25519)
                (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))
            '')
          ];
      };
    };
  };
}
