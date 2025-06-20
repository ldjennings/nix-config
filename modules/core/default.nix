{
  # inputs, 
  ...
}: {
  imports = [
    ./boot.nix
    ./greetd.nix
    ./hardware-options.nix
    ./keyd.nix
    ./mediaServer.nix
    ./monitoring.nix
    ./networking.nix
    # ./nginx.nix
    ./nfs.nix
    ./nh.nix
    ./packages.nix
    ./services.nix
    ./syncthing.nix
    ./system.nix
    ./user.nix
    ./virtualization.nix
  ];
}
