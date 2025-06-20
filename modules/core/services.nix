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
    
    # tailscale = {
    #   enable = true;
    # };

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        # CPU_MIN_PERF_ON_AC = 0;
        # CPU_MAX_PERF_ON_AC = 100;
        # CPU_MIN_PERF_ON_BAT = 0;
        # CPU_MAX_PERF_ON_BAT = 20;

        # #Optional helps save long term battery health
        # START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
        # STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
      };
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
