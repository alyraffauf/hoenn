{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.starship = inputs.nix-wrapper-modules.wrappers.starship.wrap {
      inherit pkgs;
      settings = import ./_settings.nix;
    };
  };
}
