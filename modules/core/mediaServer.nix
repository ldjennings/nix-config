{
  pkgs,
  # config,
  # lib,
  ...
}: let
  mediaDir = "/var/lib/media";
  mediaGroup = "media";
  # radarrPort = 7878;
  # sonarrPort = 8989;
  # bazarrPort = 6767;
  # prowlarrPort = 9696;
  transmissionPort = 9091;
  # tld = "home";
  # cfg = config.media_server;
in {
  # options = {
  #   media_server.enable = lib.mkEnableOption "Serve and store media from this machine";
  #   media_server.export_metrics = lib.mkOption {
  #     type = lib.types.bool;
  #     default = false;
  #     description = "Export Prometheus metrics from media services";
  #   };
  # };

    # Set up the users/groups
    users.groups = {
      streamer = {};
      torrenter = {};
      ${mediaGroup} = {
        members = [
          # "radarr"
          # "sonarr"
          # "bazarr"
          "jellyfin"
          # "zmitchell"
        ];
      };
    };
    users.users = {
      streamer = {
        isSystemUser = true;
        group = "streamer";
      };
      torrenter = {
        isSystemUser = true;
        group = "torrenter";
      };
    };

    # Create the directories that the services will need with the correct permissions
    systemd.tmpfiles.rules = [
      "d ${mediaDir} 0775 root media -"
      "d ${mediaDir}/library/Movies 0775 streamer media -"
      "d ${mediaDir}/library/TV 0775 streamer media -"
      "d ${mediaDir}/library/Audiobooks 0775 streamer media -"
      "d ${mediaDir}/torrents 0775 torrenter media -"
      "d ${mediaDir}/torrents/.incomplete 0775 torrenter media -"
      "d ${mediaDir}/torrents/.watch 0775 torrenter media -"
      # "d ${mediaDir}/torrents/radarr 0775 torrenter media -"
      # "d ${mediaDir}/torrents/sonarr 0775 torrenter media -"
      # "d ${mediaDir}/torrents/bazarr 0775 torrenter media -"
    ];

    # Set up the services
    # services.radarr = {
    #   enable = true;
    #   group = mediaGroup;
    #   openFirewall = true;
    # };
    # services.sonarr = {
    #   # The package is broken at the moment
    #   # enable = true;
    #   group = mediaGroup;
    #   openFirewall = true;
    # };
    # services.bazarr = {
    #   enable = true;
    #   group = mediaGroup;
    #   openFirewall = true;
    # };
    services.jellyfin = {
      enable = true;
      group = mediaGroup;
     # openFirewall = true;
    };
    # services.prowlarr = {
    #   enable = true;
    #   openFirewall = true;
    # };
    # services.jellyseerr = {
    #   enable = true;
    #   openFirewall = true;
    # };
    # services.sabnzbd = {
    #   enable = true;
    #   group = mediaGroup;
    # };
    services.transmission = {
      enable = true;
      user = "torrenter";
      group = mediaGroup;
      package = pkgs.transmission_4;
      openRPCPort = true;
      openPeerPorts = true;
      settings = {
        download-dir = "${mediaDir}/torrents";
        incomplete-dir-enabled = true;
        incomplete-dir = "${mediaDir}/torrents/.incomplete";
        watch-dir-enabled = true;
        watch-dir = "${mediaDir}/torrents/.watch";
        rpc-enabled = true;
        rpc-port = transmissionPort;
        rpc-bind-address =  "0.0.0.0";
        # rpc-whitelist-enabled = true;
        rpc-whitelist-enabled = false;
        # rpc-host-whitelist-enabled = false;
        rpc-authentication-required = false;
        blocklist-enabled = true;
        blocklist-url = "https://github.com/Naunter/BT_BlockLists/raw/master/bt_blocklists.gz";
        utp-enabled = true;
        encryption = 1;
        port-forwarding-enabled = false;
        download-queue-size = 10;
        cache-size-mb = 50;
        ratio-limit-enabled = true;
      };
    };
    # Always prioritize other services wrt. I/O
    systemd.services.transmission.serviceConfig.IOSchedulingPriority = 7;
    environment.systemPackages = [
      pkgs.flood-for-transmission
    ];

    systemd.network.wait-online.enable = false;
}
