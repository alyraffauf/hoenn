_: let
  userPackages = {pkgs, ...}: {
    users.users.aly.packages = with pkgs; [
      python3
      ruff
      ty
      uv
    ];
  };
in {
  flake = {
    nixosModules.aly = userPackages;
    darwinModules.aly = userPackages;

    homeModules.aly = {pkgs, ...}: {
      home.packages = with pkgs; [
        python3
      ];

      programs = {
        ruff.enable = true;
        ty.enable = true;
        uv.enable = true;
      };
    };
  };
}
