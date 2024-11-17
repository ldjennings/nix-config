# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./shell.nix
      #./vim.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix-box"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.liam = {
    isNormalUser = true;
    description = "liam";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK99EYX/L4Jz8Z243sKC7e2Tqiav3rDduXnzK8qYctyi liam@brick"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCic/BhoptoTeTP1lzBQqFtmiV78bObeUhqyrtUGpVPqbj0GhObgikeE9Qw8Y74lc0Aj309jpC5TovIyGXamfqyTYShaOSvtErOyKlCfGA9b9vhjpa6y8+DQEY+BlcDPMDYiIDXO92e1aPTsV10EA+lq/mDBDoijIQ8FOAv3Q6IJt3OMlmRT2f3Nl6PqX2j8JVjtg2t/jSNfN1WOof9kYZJbo33kdI6ElRTWxnKUptG7ODcPtWmfyTA7QfNQktAGeUbwzCabKW/KNejIC+PgkqZzgK0pRe4/DhRZ3ElhsCjKmaWQGzTCfEsZTbI+lIzEckc1O6kt5vLn/DsvTF3TJ8rIs7HuEIY/NfmROd362H4oXBFGoBmT1tsl6TGyP6r3QDFEC9A+3W5TC+XEOjcu4szJUZG8C6tfQEOa9ScLm7309R5BeZRzJPRLBo2qCf25TsCRlc2kXdAqh4OSYF93B9ZaRbc5jVuGv8euzQ6UShQtsA34jHmChf+P+2iVfDvxhc= liam@DESKTOP-BL38KQK"
    ];
  };
  users.defaultUserShell = pkgs.zsh;


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  services.tailscale = {
    enable = true;
    permitCertUid = "caddy";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  #networking.firewall.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
    trustedInterfaces = [ "tailscale0" ];
  };

  services.caddy = {
    enable = true;
    # virtualHosts."nix-box.alai-ruffe.ts.net".extraConfig = ''
    #   respond "Hello, world!"
    # '';
    virtualHosts."100.79.19.91".extraConfig = ''
      respond "Hello, world!"
    '';
    # TODO: get it so that I have actual domain names rather than just port numbers. Also close off the original ports
    virtualHosts."nix-box.alai-ruffe.ts.net:8920".extraConfig = ''
      reverse_proxy localhost:8096
    '';

    virtualHosts."nix-box.alai-ruffe.ts.net:8000".extraConfig = ''
      reverse_proxy localhost:58080
    '';


  };
  services.jellyfin = {
    enable = true;
    # openFirewall = true;
  };

  # Jellyfin libraries
  systemd.tmpfiles.rules = [
        "d /home/Jellyfin/anime 0770 jellyfin users -"
        "d /home/Jellyfin/movies 0770 jellyfin users -"
        "d /home/Jellyfin/shows 0770 jellyfin users -"
  ];

  # services.linkding.enable = true;


  services.home-assistant = {
    enable = true;
    extraComponents = [
      # Components required to complete the onboarding
      "esphome"
      "met"
      "radio_browser"
      "tplink"
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
    };
  };


  # for remote vscode from laptop
  programs.nix-ld.enable = true;

  services.paperless = {
    enable = true;
    address = "0.0.0.0";
    port = 58080;
    settings.PAPERLESS_OCR_LANGUAGE = "deu+eng";
  };
  systemd.services.paperless-scheduler.after = ["var-lib-paperless.mount"];
  systemd.services.paperless-consumer.after = ["var-lib-paperless.mount"];
  systemd.services.paperless-web.after = ["var-lib-paperless.mount"];




  services.logind.lidSwitchExternalPower = "ignore";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
