# Auto-generated using compose2nix v0.3.2-pre.
{ pkgs, lib, ... }:

{
  # Runtime


  # Containers
  virtualisation.oci-containers.containers."inventree-cache" = {
    image = "redis:7.0";
    environment = {
      "COMPOSE_PROJECT_NAME" = "inventree";
      "INVENTREE_AUTO_UPDATE" = "True";
      "INVENTREE_CACHE_ENABLED" = "True";
      "INVENTREE_CACHE_HOST" = "inventree-cache";
      "INVENTREE_CACHE_PORT" = "6379";
      "INVENTREE_DB_ENGINE" = "postgresql";
      "INVENTREE_DB_HOST" = "inventree-db";
      "INVENTREE_DB_NAME" = "inventree";
      "INVENTREE_DB_PASSWORD" = "pgpassword";
      "INVENTREE_DB_PORT" = "5432";
      "INVENTREE_DB_USER" = "pguser";
      "INVENTREE_EXT_VOLUME" = "./inventree-data";
      "INVENTREE_GUNICORN_TIMEOUT" = "90";
      "INVENTREE_LOG_LEVEL" = "WARNING";
      "INVENTREE_PLUGINS_ENABLED" = "True";
      "INVENTREE_SITE_URL" = "http://inventree.localhost";
      "INVENTREE_TAG" = "stable";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=inventree-cache"
      "--network=inventree_default"
    ];
  };
  systemd.services."podman-inventree-cache" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-inventree_default.service"
    ];
    requires = [
      "podman-network-inventree_default.service"
    ];
    partOf = [
      "podman-compose-inventree-root.target"
    ];
    wantedBy = [
      "podman-compose-inventree-root.target"
    ];
  };
  virtualisation.oci-containers.containers."inventree-db" = {
    image = "postgres:13";
    environment = {
      "PGDATA" = "/var/lib/postgresql/data/pgdb";
      "POSTGRES_DB" = "inventree";
      "POSTGRES_PASSWORD" = "pgpassword";
      "POSTGRES_USER" = "pguser";
    };
    volumes = [
      "/var/lib/podData/inventree/inventree-data:/var/lib/postgresql/data:rw,z"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=inventree-db"
      "--network=inventree_default"
    ];
  };
  systemd.services."podman-inventree-db" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-inventree_default.service"
    ];
    requires = [
      "podman-network-inventree_default.service"
    ];
    partOf = [
      "podman-compose-inventree-root.target"
    ];
    wantedBy = [
      "podman-compose-inventree-root.target"
    ];
  };
  virtualisation.oci-containers.containers."inventree-server" = {
    image = "inventree/inventree:stable";
    environment = {
      "COMPOSE_PROJECT_NAME" = "inventree";
      "INVENTREE_AUTO_UPDATE" = "True";
      "INVENTREE_CACHE_ENABLED" = "True";
      "INVENTREE_CACHE_HOST" = "inventree-cache";
      "INVENTREE_CACHE_PORT" = "6379";
      "INVENTREE_DB_ENGINE" = "postgresql";
      "INVENTREE_DB_HOST" = "inventree-db";
      "INVENTREE_DB_NAME" = "inventree";
      "INVENTREE_DB_PASSWORD" = "pgpassword";
      "INVENTREE_DB_PORT" = "5432";
      "INVENTREE_DB_USER" = "pguser";
      "INVENTREE_EXT_VOLUME" = "./inventree-data";
      "INVENTREE_GUNICORN_TIMEOUT" = "90";
      "INVENTREE_LOG_LEVEL" = "WARNING";
      "INVENTREE_PLUGINS_ENABLED" = "True";
      "INVENTREE_SITE_URL" = "http://inventree.localhost";
      "INVENTREE_TAG" = "stable";
    };
    volumes = [
      "/var/lib/podData/inventree/inventree-data:/home/inventree/data:rw,z"
    ];
    dependsOn = [
      "inventree-cache"
      "inventree-db"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=inventree-server"
      "--network=inventree_default"
    ];
  };
  systemd.services."podman-inventree-server" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-inventree_default.service"
    ];
    requires = [
      "podman-network-inventree_default.service"
    ];
    partOf = [
      "podman-compose-inventree-root.target"
    ];
    wantedBy = [" YUo./o"
      "podman-compose-inventree-root.target"
    ];
  };
  virtualisation.oci-containers.containers."inventree-worker" = {
    image = "inventree/inventree:stable";
    environment = {
      "COMPOSE_PROJECT_NAME" = "inventree";
      "INVENTREE_AUTO_UPDATE" = "True";
      "INVENTREE_CACHE_ENABLED" = "True";
      "INVENTREE_CACHE_HOST" = "inventree-cache";
      "INVENTREE_CACHE_PORT" = "6379";
      "INVENTREE_DB_ENGINE" = "postgresql";
      "INVENTREE_DB_HOST" = "inventree-db";
      "INVENTREE_DB_NAME" = "inventree";
      "INVENTREE_DB_PASSWORD" = "pgpassword";
      "INVENTREE_DB_PORT" = "5432";
      "INVENTREE_DB_USER" = "pguser";
      "INVENTREE_EXT_VOLUME" = "./inventree-data";
      "INVENTREE_GUNICORN_TIMEOUT" = "90";
      "INVENTREE_LOG_LEVEL" = "WARNING";
      "INVENTREE_PLUGINS_ENABLED" = "True";
      "INVENTREE_SITE_URL" = "http://inventree.localhost";
      "INVENTREE_TAG" = "stable";
    };
    volumes = [
      "/var/lib/podData/inventree/inventree-data:/home/inventree/data:rw,z"
    ];
    cmd = [ "invoke" "worker" ];
    dependsOn = [
      "inventree-server"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=inventree-worker"
      "--network=inventree_default"
    ];
  };
  systemd.services."podman-inventree-worker" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-inventree_default.service"
    ];
    requires = [
      "podman-network-inventree_default.service"
    ];
    partOf = [
      "podman-compose-inventree-root.target"
    ];
    wantedBy = [
      "podman-compose-inventree-root.target"
    ];
  };

  # Networks
  systemd.services."podman-network-inventree_default" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "podman network rm -f inventree_default";
    };
    script = ''
      podman network inspect inventree_default || podman network create inventree_default
    '';
    partOf = [ "podman-compose-inventree-root.target" ];
    wantedBy = [ "podman-compose-inventree-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."podman-compose-inventree-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
