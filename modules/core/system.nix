{
  # pkgs,
  # host,
  ...
}: {
  nix = {
    settings = {
      download-buffer-size = 250000000;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # for remote vscode editing
  programs.nix-ld.enable = true;

  # bottom for headless, top for screen still on when plugged in and closed
  # services.logind.lidSwitchExternalPower = "ignore";
  services.logind.lidSwitch = "ignore";

  # environment.variables = {

  # };

  system.stateVersion = "25.05"; # Do not change!
}
