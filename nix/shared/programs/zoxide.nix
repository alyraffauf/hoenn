_: {
  flake = {
    homeModules.aly = {
      programs.zoxide = {
        enable = true;
        options = ["--cmd cd"];
      };
    };

    nixosModules.default = {
      programs.zoxide = {
        enable = true;
        flags = ["--cmd cd"];
      };
    };
  };
}
