{
  config,
  # lib,
  ...
}: {
  services.prometheus = {
    enable = true;
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [
          "systemd"
        ];
      };
    };
    port = 9090;
    scrapeConfigs = [
      {
        job_name = "node_scrape";
        static_configs = [
          {
            targets = [
              "127.0.0.1:${builtins.toString config.services.prometheus.exporters.node.port}"
            ];
          }
        ];
      }
    ];
  };
  services.grafana = {
    enable = true;
    settings.server.domain = "0.0.0.0";
    settings.server.http_port = 3000;
    provision = {
      enable = true;
      datasources.settings.datasources = [
        {
          name = "prometheus";
          type = "prometheus";
          url = "localhost:${builtins.toString config.services.prometheus.port}";
          isDefault = true;
        }
      ];
    };
  };
  #  networking.firewall.allowedTCPPorts = [
  # 	cfg.grafana.port
  # ];
}
