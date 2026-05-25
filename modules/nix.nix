{ config, ... }:
let
  nixSettings = {
    "extra-experimental-features" = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      config.primaryUser.username
    ];
  };

  nixGc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };
in
{
  flake.modules.nixos.nix_settings = {
    nix.settings = nixSettings;
    nix.gc = nixGc;
  };
}
