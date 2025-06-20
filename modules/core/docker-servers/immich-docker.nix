# Auto-generated using compose2nix v0.3.2-pre.
{ pkgs, lib, config, ... }:

 {

    # Create the directories that the services will need with the correct permissions


  # Runtime
  # virtualisation.podman = {
  #   enable = true;
  #   autoPrune.enable = true;
  #   dockerCompat = true;
  # };

  # # Enable container name DNS for all Podman networks.
  # networking.firewall.interfaces = let
  #   matchAll = if !config.networking.nftables.enable then "podman+" else "podman*";
  # in {
  #   "${matchAll}".allowedUDPPorts = [ 53 ];
  # };

  # virtualisation.oci-containers.backend = "podman";

  # Containers
  virtualisation.oci-containers.containers."immich_machine_learning" = {
    image = "ghcr.io/immich-app/immich-machine-learning:release";
    environment = {
      "DB_DATABASE_NAME" = "immich";
      "DB_DATA_LOCATION" = "./postgres";
      "DB_PASSWORD" = "postgres";
      "DB_USERNAME" = "postgres";
      "IMMICH_VERSION" = "release";
      "UPLOAD_LOCATION" = "./library";
    };
    volumes = [
      "immich_model-cache:/cache:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=immich-machine-learning"
      "--network=immich_default"
    ];
  };
  systemd.services."podman-immich_machine_learning" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-immich_default.service"
      "podman-volume-immich_model-cache.service"
    ];
    requires = [
      "podman-network-immich_default.service"
      "podman-volume-immich_model-cache.service"
    ];
    partOf = [
      "podman-compose-immich-root.target"
    ];
    wantedBy = [
      "podman-compose-immich-root.target"
    ];
  };
  virtualisation.oci-containers.containers."immich_postgres" = {
    image = "ghcr.io/immich-app/postgres:14-vectorchord0.4.2-pgvectors0.2.0";
    environment = {
      "POSTGRES_DB" = "immich";
      "POSTGRES_INITDB_ARGS" = "--data-checksums";
      "POSTGRES_PASSWORD" = "postgres";
      "POSTGRES_USER" = "postgres";
    };
    volumes = [
      "/var/lib/podData/immich/postgres:/var/lib/postgresql/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=database"
      "--network=immich_default"
    ];
  };
  systemd.services."podman-immich_postgres" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-immich_default.service"
    ];
    requires = [
      "podman-network-immich_default.service"
    ];
    partOf = [
      "podman-compose-immich-root.target"
    ];
    wantedBy = [
      "podman-compose-immich-root.target"
    ];
  };
  virtualisation.oci-containers.containers."immich_redis" = {
    image = "docker.io/valkey/valkey:8-bookworm@sha256:fec42f399876eb6faf9e008570597741c87ff7662a54185593e74b09ce83d177";
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=redis-cli ping || exit 1"
      "--network-alias=redis"
      "--network=immich_default"
    ];
  };
  systemd.services."podman-immich_redis" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-immich_default.service"
    ];
    requires = [
      "podman-network-immich_default.service"
    ];
    partOf = [
      "podman-compose-immich-root.target"
    ];
    wantedBy = [
      "podman-compose-immich-root.target"
    ];
  };
  virtualisation.oci-containers.containers."immich_server" = {
    image = "ghcr.io/immich-app/immich-server:release";
    environment = {
      "DB_DATABASE_NAME" = "immich";
      "DB_DATA_LOCATION" = "./postgres";
      "DB_PASSWORD" = "postgres";
      "DB_USERNAME" = "postgres";
      "IMMICH_VERSION" = "release";
      "UPLOAD_LOCATION" = "./library";
    };
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/var/lib/podData/immich/library:/usr/src/app/upload:rw"
    ];
    ports = [
      "2283:2283/tcp"
    ];
    dependsOn = [
      "immich_postgres"
      "immich_redis"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=immich-server"
      "--network=immich_default"
      # "--user=immich"
    ];
  };
  systemd.services."podman-immich_server" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-immich_default.service"
    ];
    requires = [
      "podman-network-immich_default.service"
    ];
    partOf = [
      "podman-compose-immich-root.target"
    ];
    wantedBy = [
      "podman-compose-immich-root.target"
    ];
  };

  # Networks
  systemd.services."podman-network-immich_default" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "podman network rm -f immich_default";
    };
    script = ''
      podman network inspect immich_default || podman network create immich_default
    '';
    partOf = [ "podman-compose-immich-root.target" ];
    wantedBy = [ "podman-compose-immich-root.target" ];
  };

  # Volumes
  systemd.services."podman-volume-immich_model-cache" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect immich_model-cache || podman volume create immich_model-cache
    '';
    partOf = [ "podman-compose-immich-root.target" ];
    wantedBy = [ "podman-compose-immich-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."podman-compose-immich-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
