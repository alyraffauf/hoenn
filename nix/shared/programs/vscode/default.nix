_: {
  flake = {
    darwinModules.aly = {
      homebrew.casks = ["visual-studio-code"];
    };

    nixosModules.aly = {pkgs, ...}: {
      users.users.aly.packages = [pkgs.vscode];
    };
  };
}
