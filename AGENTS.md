# Work in Hoenn

Hoenn configures personal machines. It contains NixOS, nix-darwin, Home Manager, and system-manager configurations. Keep host-specific state in `nix/hosts/<platform>/<host>/`. Put shared platform settings in `nix/nixos/`, `nix/darwin/`, or `nix/system-manager/`.

`flake.nix` imports the Nix files under `nix/`. `keys/` holds public recipients. `secrets/` holds SOPS-encrypted files. `scripts/` holds maintenance tools.

## Check a change

Run `nix fmt` and `nix flake check` before you commit. Build each output affected by the change.

```sh
nix build .#nixosConfigurations.<host>.config.system.build.toplevel
nix build .#darwinConfigurations.fortree.config.system.build.toplevel
nix build .#systemConfigs.sootopolis
```

If a NixOS host's `facter.json` changes, run `nix run github:alyraffauf/infra#generate-host-readmes`. Do not edit text between generated-section markers in a host README.

## Deploy deliberately

`mauville` is the registered `blzrd` node. Run `blzrd switch mauville` to activate it, or `blzrd boot mauville` to set its next boot. Do not use a bare `blzrd switch` unless you mean to target every registered node. Never deploy only to test a configuration.

## Keep secrets out of Git

Do not commit decrypted secrets or private keys. Use `just sops-edit <file>.yaml` to edit a secret. When `keys/` changes, run `just sops-rekey`, review `.sops.yaml` and every encrypted file, then commit them together.
