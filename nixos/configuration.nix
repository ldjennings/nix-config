# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputsadd, ... }:



{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./gc.nix
      ./virtualization.nix
      (import ./gnome.nix {
        inherit pkgs;
      })
      (import ./nix-ld.nix {
        inherit pkgs;
      })
      (import ./packages.nix {
        inherit pkgs;
      })
      (import ./graphics.nix {
        inherit pkgs;
      })
      (import ./nix-ld.nix {
        inherit pkgs;
      })
      
    ];

    # TODO: make boot and shutdown entirely silent
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    boot.loader.grub.useOSProber = true;
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.splashImage = "/home/liam/Downloads/cited.png";
    # This makes it so you need to hold esc to access the options
    boot.loader.grub.timeoutStyle = "hidden";

  networking.hostName = "selfdestruction"; # Define your hostname.
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

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk             # alternatively, kdePackages.fcitx5-qt
      fcitx5-chinese-addons  # table input method support
      fcitx5-nord            # a color theme
    ];
  };


 fonts.fontDir.enable = true;
 fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-extra 
      noto-fonts-cjk-sans 
      noto-fonts-cjk-serif
      noto-fonts-emoji
    ];
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.liam = {
    isNormalUser = true;
    description = "liam";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # Enable sound with pipewire. Configured further in the services section
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  

  # All active user configured services on the system
  services = {
    # Enabling flatpak for everest and other programs
    flatpak.enable = true;
    
    # fingerprint sensor service
    fprintd.enable = false;
    
    # Enable CUPS to print documents
    printing.enable = true;
    
    # Basic keyboard config
    xserver.xkb = {
      layout = "us";
      variant = "colemak";
    };

    # Periodic SSD Trimming
    fstrim.enable = true;

    # Bios updates
    fwupd.enable = true;

    # Audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
  
      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Base Touchpad support. This should usually be enabled by default.
    # xserver.libinput.enable = true;

};



# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;
  programs.zsh.ohMyZsh.enable = true;
  

  programs.steam.enable = true;


  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # HACK: this is to get around the old version of stm32cubemx.
  environment.variables = {CUBEMX_COMMAND = "steam-run /home/liam/STM32CubeMX/STM32CubeMX";};



  boot.tmp.cleanOnBoot = true;




  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
