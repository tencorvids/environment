{
  flake.modules.nixos.virt = {
    virtualisation.docker = {
      enable = true;
      rootless.enable = true;
    };
  };
}
