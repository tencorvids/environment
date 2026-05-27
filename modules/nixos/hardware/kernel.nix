{
  flake.modules.nixos.kernel =
    { pkgs, ... }:
    {
      boot.kernelPackages = pkgs.linuxPackages_latest;

      boot.consoleLogLevel = 3;
      boot.initrd.verbose = false;
      boot.kernelParams = [
        "quiet"
        "udev.log_level=3"
        "systemd.show_status=auto"
      ];
    };
}
