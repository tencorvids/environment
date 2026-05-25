{ config, ... }:
{

  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "${config.primaryUser.username}";
          email = "${config.primaryUser.email}";
        };
      };
    };
  };
}
