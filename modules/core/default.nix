{
  # inputs, 
  ...
}: {
  imports = [
    ./boot.nix
    ./greetd.nix
    ./hardware-options.nix
    # ./immich-docker.nix
    ./docker-servers
    ./keyd.nix
    ./mediaServer.nix
    ./monitoring.nix
    ./networking.nix
    # ./nginx.nix
    ./nfs.nix
    ./nh.nix
    ./packages.nix
    ./power.nix
    ./services.nix
    ./syncthing.nix
    ./system.nix
    ./user.nix
    ./virtualization.nix
  ];
}
