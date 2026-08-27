{inputs, ...}: {
  flake = {
    nixosModules.default = {
      imports = [inputs.helium-browser.nixosModules.default];

      programs.helium.enable = true;
    };

    darwinModules.default = {
      homebrew.casks = ["helium-browser"];
    };
  };
}
