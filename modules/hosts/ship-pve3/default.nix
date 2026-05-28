{
  inputs,
  ...
}:
let
  vars = inputs.self.vars.user;
in
{
  flake.nixosConfigurations.ship_pve3 = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs vars;
    };

    modules = with inputs.self.modules.nixos; [
      base
      grub_boot
      kernel
      qemu_guest
      virt

      ({
        pkgs,
        ...
      }:
      {
        imports = [
          ./_hardware-configuration.nix
          ./_home.nix
          inputs.home-manager.nixosModules.default
        ];

        home-manager.extraSpecialArgs = {
          inherit vars;
        };

        networking.hostName = "ship-pve3";
        networking.useDHCP = false;
        networking.interfaces.ens18.ipv4.addresses = [
          {
            address = "10.10.10.13";
            prefixLength = 24;
          }
        ];
        networking.defaultGateway = "10.10.10.1";
        networking.nameservers = [ "10.10.10.1" "1.1.1.1" "9.9.9.9" ];

        systemd.services.komodo-compose = {
          description = "Komodo docker compose stack";
          after = [ "docker.service" "network-online.target" ];
          wants = [ "network-online.target" ];
          requires = [ "docker.service" ];
          wantedBy = [ "multi-user.target" ];
          path = [ pkgs.docker ];

          unitConfig.ConditionPathExists = "/var/lib/stacks/komodo/.env";

          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            WorkingDirectory = "/home/${vars.username}/stacks/komodo";
            ExecStart = "${pkgs.bash}/bin/bash -lc 'docker compose -f compose.yaml --env-file /var/lib/stacks/komodo/.env up -d'";
            ExecStop = "${pkgs.bash}/bin/bash -lc 'docker compose -f compose.yaml --env-file /var/lib/stacks/komodo/.env down'";
          };
        };
      })
    ];
  };
}
