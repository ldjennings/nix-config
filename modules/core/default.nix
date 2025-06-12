{
  # inputs, 
  ...
}: {
  imports = [
    ./boot.nix
    ./greetd.nix
    ./hardware-options.nix
    ./networking.nix
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
