{ inputs, pkgs, ...}:

{

  imports =
  [
     inputs.nixos-hardware.nixosModules.framework-13-12th-gen-intel
  ];

  services =
  {
    fstrim.enable = true; # Disk
  };

  services.fwupd = # Bios updates
  {
    enable = true;
    extraRemotes = [ "lvfs-testing" ];
  };

}
