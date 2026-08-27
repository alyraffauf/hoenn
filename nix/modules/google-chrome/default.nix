_: {
  flake = {
    nixosModules.google-chrome = {pkgs, ...}: {
      environment.systemPackages = [pkgs.google-chrome];
    };

    darwinModules.google-chrome = {
      homebrew.casks = ["google-chrome"];
    };
  };
}
