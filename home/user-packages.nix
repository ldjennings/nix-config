{ pkgs  }:
{
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # liam's personal packages
    kicad-small
    discord
    zoom-us
    slack
    jetbrains-toolbox
    spotify
    obsidian
    gimp
    qbittorrent
    # Note: nix-rebuild was hanging when trying to install and build both of these from source. If issues like
    # this are encountered, comment out stm32cubemx, rebuild, and uncomment it 
    stm32cubemx
    #gcc-arm-embedded
    gcc-arm-embedded-13

    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
    neofetch
    vlc
    # vlc-bittorrent
    openai-whisper
    orca-slicer
    yt-dlp
    ncdu
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
