{
  # pkgs,
  ...
}: {
  # Services to start
  services = {
    libinput.enable = true; # Input Handling
    fstrim.enable = true; # SSD Optimizer
    gvfs.enable = true; # For Mounting USB & More
    # openssh.enable = true; # Enable SSH
    gnome.gnome-keyring.enable = true;

    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };

    tailscale = {
      enable = true;
    };




  };
  # systemd.services.set-blanking = {
  #   description = "Configure console screen blanking";
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.util-linux}/bin/setterm --blank 1 --powersave powerdown --powerdown 1";
  #   };
  # };
}
