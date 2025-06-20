{
  host,
  ...
}: {
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    firewall = {
      enable = false;
    #  allowedTCPPorts = [
    #    22
    #     80
    #     443
    #     59010
    #     59011
    #     8080
    #   ];
    #   allowedUDPPorts = [
    #     59010
    #     59011
    #   ];
    };
  };
}
