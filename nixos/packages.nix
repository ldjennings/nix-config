{ pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    zsh
    gcc
    clang
    gnumake
    python312Packages.pip
    python312
    pipx
    loupe
    bash
    fuse
    love
 

    intel-gpu-tools
    home-manager
    lf
  ];


}
