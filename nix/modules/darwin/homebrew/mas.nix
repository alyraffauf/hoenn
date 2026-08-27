_: {
  flake.darwinModules.darwin = {
    homebrew = {
      enable = true;

      brews = [
        "mas"
      ];
    };
  };
}
