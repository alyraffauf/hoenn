_: {
  flake.homeModules.syncthing = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf mkMerge mkOption types;

    cfg = config.hoenn.syncthing;

    folderType = defaults:
      types.submodule ({name, ...}: {
        options = {
          enable = mkEnableOption "the ${name} Syncthing folder";

          path = mkOption {
            type = types.strMatching "(/|~/).*";
            default = defaults.path;
            description = "Absolute path or path relative to the home directory for this folder.";
          };

          id = mkOption {
            type = types.nonEmptyStr;
            default = defaults.id;
            description = "Syncthing folder ID, which must be identical on every peer.";
          };

          label = mkOption {
            type = types.nonEmptyStr;
            default = defaults.label or name;
            description = "Human-readable label for this folder in Syncthing.";
          };

          devices = mkOption {
            type = types.listOf types.nonEmptyStr;
            default = defaults.devices;
            description = "Names of the Syncthing devices that share this folder.";
          };

          ignorePatterns = mkOption {
            type = types.nullOr (types.listOf types.str);
            default = defaults.ignorePatterns or null;
            description = "Patterns for files Syncthing must ignore in this folder.";
          };

          versioning = mkOption {
            type = types.nullOr (types.submodule {
              options = {
                type = mkOption {
                  type = types.enum ["external" "simple" "staggered" "trashcan"];
                  description = "Syncthing versioning strategy.";
                };

                params = mkOption {
                  type = types.attrsOf types.str;
                  default = {};
                  description = "Parameters for the selected versioning strategy.";
                };
              };
            });
            default = defaults.versioning or null;
            description = "Optional versioning configuration for this folder.";
          };
        };
      });

    deviceType = types.submodule {
      options = {
        id = mkOption {
          type = types.nonEmptyStr;
          description = "Syncthing device ID.";
        };

        introducer = mkOption {
          type = types.bool;
          default = false;
          description = "Whether this device introduces other Syncthing peers.";
        };
      };
    };

    enabledFolder = folder:
      mkIf folder.enable {
        "${folder.path}" = {
          inherit (folder) devices id ignorePatterns label versioning;
        };
      };
  in {
    options.hoenn.syncthing = {
      enable = mkEnableOption "Syncthing with Hoenn's shared folders";

      devices = mkOption {
        type = types.attrsOf deviceType;
        default = {
          eterna.id = "ZAD2MVO-I2OQII4-C3T756B-BEBQMM6-Q4ILH2H-5CR3TMI-DR4VBFD-GLRVOQK";
          jubilife = {
            id = "52MTCMC-PKEWSAU-HADMTZU-DY5EKFO-B323P7V-OBXLNTQ-EJY7F7Y-EUWFBQX";
            introducer = true;
          };
          snowpoint.id = "TFSZWZB-EDIFV2P-333APP2-T655TM4-2XGA7QA-P22Z36W-3RNGX2C-DLETAQ7";
        };
        description = "Syncthing peers available to the managed folders.";
      };

      folders = {
        sync = mkOption {
          type = folderType {
            path = "~/Sync";
            id = "default";
            devices = ["eterna" "jubilife" "snowpoint"];
            versioning = {
              type = "trashcan";
              params.cleanoutDays = "5";
            };
          };
          default = {};
          description = "Configuration for the shared Sync folder.";
        };

        roms = mkOption {
          type = folderType {
            path = "~/ROMs";
            id = "emudeck";
            devices = ["eterna" "jubilife"];
            ignorePatterns = ["androidapps" "emulators"];
          };
          default = {};
          description = "Configuration for the shared ROMs folder.";
        };
      };
    };

    config = mkIf cfg.enable {
      assertions = [
        {
          assertion = !(cfg.folders.sync.enable && cfg.folders.roms.enable && cfg.folders.sync.path == cfg.folders.roms.path);
          message = "hoenn.syncthing folders.sync and folders.roms must use different paths.";
        }
      ];

      services.syncthing = {
        enable = true;
        overrideDevices = false;
        overrideFolders = false;

        settings = {
          devices =
            lib.mapAttrs (_: device: {
              inherit (device) id introducer;
            })
            cfg.devices;

          folders = mkMerge [
            (enabledFolder cfg.folders.sync)
            (enabledFolder cfg.folders.roms)
          ];
        };
      };
    };
  };
}
