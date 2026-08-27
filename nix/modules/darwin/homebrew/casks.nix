_: {
  flake.darwinModules.darwin = {
    homebrew = {
      enable = true;
      greedyCasks = true;
    };
  };
}
