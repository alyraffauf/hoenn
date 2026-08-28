{inputs, ...}: {
  flake.nixosModules.comin = {...}: {
    imports = [inputs.comin.nixosModules.comin];

    services.comin = {
      enable = true;

      remotes = [
        {
          name = "origin";
          url = "https://github.com/alyraffauf/hoenn.git";
          branches.main.name = "master";
          poller.period = 600;
        }
      ];
    };
  };
}
