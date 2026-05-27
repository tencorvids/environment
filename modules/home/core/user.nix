{ ... }:
{
  flake.modules.homeManager.user =
    { pkgs, vars, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      hasSuffix = pkgs.lib.hasSuffix;
      homeDir = if hasSuffix "linux" system then "/home" else "/Users";
    in
    {
      home.username = vars.username;
      home.homeDirectory = "${homeDir}/${vars.username}";
    };
}
