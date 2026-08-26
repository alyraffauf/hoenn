{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.ripgrep = inputs.nix-wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.ripgrep;
      addFlag = ["--pretty"];
      unsetVar = ["RIPGREP_CONFIG_PATH"];
    };
  };
}
