{inputs, ...}: let
  systemModule = {
    sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  };
in {
  flake = {
    nixosModules.default =
      {
        imports = [inputs.sops-nix.nixosModules.sops];
      }
      // systemModule;

    darwinModules.default =
      {
        imports = [inputs.sops-nix.darwinModules.sops];
      }
      // systemModule;

    homeModules.aly = {config, ...}: {
      imports = [inputs.sops-nix.homeManagerModules.sops];

      sops.age.sshKeyPaths = ["${config.home.homeDirectory}/.ssh/id_ed25519"];
    };
  };
}
