{ inputs, ... }:
{
  flake.modules.homeManager.base = {
    home.stateVersion = "23.05";
    imports = with inputs.self.modules.homeManager; [
      user
      nixpkgs_settings
      core
    ];
  };
}
