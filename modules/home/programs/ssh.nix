{
  flake.modules.homeManager.ssh = {
    programs.ssh.enable = true;
    services.ssh-agent.enable = true;
  };
}
