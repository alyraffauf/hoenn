_: {
  flake.nixosModules.nixos = {
    boot.kernel.sysctl = {
      "vm.swappiness" = 180;
      "vm.page-cluster" = 0;
    };

    zramSwap = {
      enable = true;
      algorithm = "zstd";
      priority = 100;
    };
  };
}
