{...}:
# this config is designed for a server, but I'm running it on a framework laptop that I have sitting around. Because of that,
# I need to do stuff like disabling the wifi card, bluetooth, touchpad, etc. to minimize power consumption
{
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "power";

      # CPU_MIN_PERF_ON_AC = 0;
      # CPU_MAX_PERF_ON_AC = 100;
      # CPU_MIN_PERF_ON_BAT = 0;
      # CPU_MAX_PERF_ON_BAT = 20;

      # #Optional helps save long term battery health
      # START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      # STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    };
  };

  # turning off bluetooth
  hardware.bluetooth.enable = false;
  hardware.bluetooth.powerOnBoot = false;

  # shutting off the display after 60 seconds
  boot.kernelParams = ["consoleblank=60"];

  # sound.enable = false;
  services.pulseaudio.enable = false;
  services.pipewire.enable = false;

  # disabling the touchpad, wifi card, 
  boot.blacklistedKernelModules = [
    "psmouse"
    "iwlwifi"
  ];
}
