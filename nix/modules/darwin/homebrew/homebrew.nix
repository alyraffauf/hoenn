_: {
  flake.darwinModules.darwin = {
    homebrew = {
      enable = true;
      global.autoUpdate = true;

      onActivation = {
        # cleanup = "zap";
        upgrade = true;
      };
    };
  };
}
