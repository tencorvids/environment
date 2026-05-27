{
  flake.modules.nixos.qemu_guest = {
    services.qemuGuest.enable = true;
  };
}
