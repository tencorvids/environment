{ ... }:
{
  flake.modules.homeManager.git =
    { vars, ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = vars.username;
            email = vars.email;
          };
        };
      };
    };
}
