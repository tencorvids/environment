{
  flake.modules.nixos.grub_boot = {
    boot.loader.systemd-boot.enable = false;
    boot.loader.efi.canTouchEfiVariables = false;

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
  };
}
