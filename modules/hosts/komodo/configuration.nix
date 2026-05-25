{
  inputs,
  config,
  ...
}:
{
  flake.nixosConfigurations.komodo = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.modules.nixos; [
      base
      docker
      grub_boot
      kernel

      {
        imports = [
          ./_hardware-configuration.nix
          inputs.home-manager.nixosModules.default
        ];

        networking.hostName = "komodo";
        networking.useDHCP = false;
        networking.interfaces.ens18.ipv4.addresses = [
          {
            address = "10.10.10.12";
            prefixLength = 24;
          }
        ];
        networking.defaultGateway = "10.10.10.1";
        networking.nameservers = [ "10.10.10.1" "1.1.1.1" "9.9.9.9" ];

        home-manager.users.${config.primaryUser.username} = {
          imports = with inputs.self.modules.homeManager; [
            base
          ];
        };
      }
    ];
  };
}
