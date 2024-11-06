{ pkgs, ... }:

let
  # Define the overlay for stm32cubemx
  # cubeOverlay = self: super: {
    # stm32cubemx = super.stdenvNoCC.mkDerivation rec {
      # pname = "stm32cubemx";
      # version = "6.12.1";  # New version
      # src = super.fetchzip {
        # url = "https://sw-center.st.com/packs/resource/library/stm32cube_mx_v${builtins.replaceStrings ["."] [""] version}-lin.zip";
        # hash = "sha256-e1b914f43795cf60a4ec6e38513478cd18208b08a11c16eeaea4b9a478fe60ae";  # Correct sha256 hash for 6.12.1
        # stripRoot = false;
      # };
    # };
  # };
# 
  # cube = import <nixpkgs> {
    # overlays = [ cubeOverlay ];  # Apply overlay to nixpkgs
  # };

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in
{
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # liam's personal packages
    kicad
    discord
    zoom-us
    slack
    jetbrains-toolbox
    spotify
    obsidian
    gimp
    qbittorrent
    gnome.dconf-editor
    calibre
    unstable.freecad

    # Uncomment to install stm32cubemx with the overlay applied
    # stm32cubemx
    # stm32cubemx

    # Ensure gcc-arm-embedded is included (specify the exact version if necessary)
    gcc-arm-embedded-13
    kicad

    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
    neofetch
    vlc
    # vlc-bittorrent
    openai-whisper
    orca-slicer
    yt-dlp
    ncdu
    tmux
    platformio

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];
}

