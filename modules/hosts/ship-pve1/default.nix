{
  inputs,
  ...
}:
let
  vars = inputs.self.vars.user;
in
{
  flake.nixosConfigurations.ship_pve1 = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs vars;
    };

    modules = with inputs.self.modules.nixos; [
      base
      grub_boot
      kernel
      virt

      {
        imports = [
          ./_hardware-configuration.nix
          ./_home.nix
          inputs.home-manager.nixosModules.default
        ];

        home-manager.extraSpecialArgs = {
          inherit vars;
        };

        networking.hostName = "ship-pve1";
        networking.useDHCP = false;
        networking.interfaces.ens18.ipv4.addresses = [
          {
            address = "10.10.10.12";
            prefixLength = 24;
          }
        ];
        networking.defaultGateway = "10.10.10.1";
        networking.nameservers = [ "10.10.10.1" "1.1.1.1" "9.9.9.9" ];
      }
    ];
  };
}
