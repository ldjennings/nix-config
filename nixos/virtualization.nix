{ ... }:

{



  boot.kernelModules = [ "kvm-intel" ];


  virtualisation = # NOT VIRTUALIZATION
  {
    libvirtd.enable = true;
    docker.enable = true;
  };


}
