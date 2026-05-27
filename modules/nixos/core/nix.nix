{ ... }:
{
  flake.modules.nixos.nix_settings =
    { vars, ... }:
    {
      nix.settings = {
        "extra-experimental-features" = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [
          "root"
          vars.username
        ];
      };

      nix.gc = {
        automatic = true;
        options = "--delete-older-than 30d";
      };
    };
}
