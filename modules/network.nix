{
  flake.modules.nixos.network =
    { pkgs, ... }:
    {
      networking.networkmanager = {
        enable = true;
      };
    };

}
