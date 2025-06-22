{
  # inputs,
  config,
  ...
}: let
  podDir = "/var/lib/podData";
in {
  users.groups = {
    podServers = {};
  };
  users.users = {
    immich = {
      isSystemUser = true;
      group = "podServers";
    };
    inventree = {
      isSystemUser = true;
      group = "podServers";
    };
  };

  systemd.tmpfiles.rules = [
    "d ${podDir} 0775 root podServers -"
    "d ${podDir}/immich/library 0775 immich podServers -"
    "d ${podDir}/immich/postgres 0775 immich podServers -"
    "d ${podDir}/inventree/inventree-data 0777 inventree podServers -"
    # "d ${podDir}/torrents 0775 torrenter podServers -"
    # "d ${podDir}/torrents/.incomplete 0775 torrenter podServers -"
    # "d ${podDir}/torrents/.watch 0775 torrenter podServers -"
  ];

  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
  };

  # Enable container name DNS for all Podman networks.
  networking.firewall.interfaces = let
    matchAll =
      if !config.networking.nftables.enable
      then "podman+"
      else "podman*";
  in {
    "${matchAll}".allowedUDPPorts = [53];
  };

  virtualisation.oci-containers.backend = "podman";

  imports = [
    ./immich-docker.nix
    ./inventree-docker.nix
  ];
}
