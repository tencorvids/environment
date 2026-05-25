{ inputs, ... }:
{
  flake.modules.nixos.base = {
    system.stateVersion = "25.11";
    imports = with inputs.self.modules.nixos; [
      nix_settings
      nixpkgs_settings
      user
      network
      ssh
    ];
  };

  flake.modules.homeManager.base = {
    home.stateVersion = "23.05";
    imports = []
    ++ (with inputs.self.modules.homeManager; [
      user
      nixpkgs_settings
      core
    ]);
  };
}
