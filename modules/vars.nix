{ lib, ... }:

let
  userOpts =
    { ... }:
    {
      options = {
        username = lib.mkOption {
          type = lib.types.str;
          default = "rew";
        };
        firstName = lib.mkOption {
          type = lib.types.str;
          default = "Andrew";
        };
        lastName = lib.mkOption {
          type = lib.types.str;
          default = "Vota";
        };
        email = lib.mkOption {
          type = lib.types.str;
          default = "rew@tencorvids.com";
        };
        publicSSHKeys = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };
        timeZone = lib.mkOption {
          type = lib.types.str;
          default = "America/New_York";
        };
      };
    };
in
{
  options.primaryUser = lib.mkOption {
    type = lib.types.submodule userOpts;
    default = { };
  };
}
