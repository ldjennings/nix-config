{...}: {
  services.nginx = {
    enable = true;
    # recommendedProxySettings = true;
    # recommendedTlsSettings = true;
    # other Nginx options
    virtualHosts."jelly.example.com" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:12345";
        proxyWebsockets = true; # needed if you need to use WebSocket
        extraConfig =
          # required when the target is also TLS server with multiple hosts
          "proxy_ssl_server_name on;"
          +
          # required when the server wants to use HTTP Authentication
          "proxy_pass_header Authorization;";
      };
    };
  };

  users.users.nginx.extraGroups = ["acme"];

  security.acme = {
    acceptTerms = true;
    defaults.email = "jenningsliamd@gmail.com";
    # Staging server for testing configurations....
    # defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
    certs = {
      "mywebsite.com" = {
        webroot = "/var/lib/acme/challenges-mywebsite";
        email = "jenningsliamd@gmail.com";
        group = "nginx";
      };
    };
  };
}
