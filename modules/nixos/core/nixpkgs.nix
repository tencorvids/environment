{
  flake.modules.nixos.nixpkgs_settings = {
    nixpkgs.config.allowUnfree = true;
  };
}
