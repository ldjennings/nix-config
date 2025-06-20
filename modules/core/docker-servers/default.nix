{
  # inputs, 
  ...
}: 
let
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
      # "d ${podDir}/library/Audiobooks 0775 streamer podServers -"
      # "d ${podDir}/torrents 0775 torrenter podServers -"
      # "d ${podDir}/torrents/.incomplete 0775 torrenter podServers -"
      # "d ${podDir}/torrents/.watch 0775 torrenter podServers -"
    ];

  imports = [
    ./immich-docker.nix 
  ];

}