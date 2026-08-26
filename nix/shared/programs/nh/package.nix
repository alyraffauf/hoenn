{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.nh = inputs.nix-wrapper-modules.wrappers.nh.wrap {
      inherit pkgs;

      flake = "github:alyraffauf/hoenn";
    };
  };
}
