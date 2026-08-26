{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.eza = inputs.nix-wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.eza;

      addFlag = [
        "--group-directories-first"
        "--header"
        "--git"
        "--icons=auto"
      ];
    };
  };
}
