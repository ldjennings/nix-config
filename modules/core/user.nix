{
  pkgs,
  inputs,
  username,
  host,
  profile,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = false;
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs username host profile;};
    users.${username} = {
      imports = [./../home];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = "25.05";
      };
    };
  };
  users.mutableUsers = true;
  users.users.${username} = {
    isNormalUser = true;
    description = "meeee";
    extraGroups = [
      "docker"
      "libvirtd"
      "lp"
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDWU3zkIkFhIXPhfzjEJeDQa3y3K7jvbHV+wU10lw7RP liam@Brick"
      # "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCic/BhoptoTeTP1lzBQqFtmiV78bObeUhqyrtUGpVPqbj0GhObgikeE9Qw8Y74lc0Aj309jpC5TovIyGXamfqyTYShaOSvtErOyKlCfGA9b9vhjpa6y8+DQEY+BlcDPMDYiIDXO92e1aPTsV10EA+lq/mDBDoijIQ8FOAv3Q6IJt3OMlmRT2f3Nl6PqX2j8JVjtg2t/jSNfN1WOof9kYZJbo33kdI6ElRTWxnKUptG7ODcPtWmfyTA7QfNQktAGeUbwzCabKW/KNejIC+PgkqZzgK0pRe4/DhRZ3ElhsCjKmaWQGzTCfEsZTbI+lIzEckc1O6kt5vLn/DsvTF3TJ8rIs7HuEIY/NfmROd362H4oXBFGoBmT1tsl6TGyP6r3QDFEC9A+3W5TC+XEOjcu4szJUZG8C6tfQEOa9ScLm7309R5BeZRzJPRLBo2qCf25TsCRlc2kXdAqh4OSYF93B9ZaRbc5jVuGv8euzQ6UShQtsA34jHmChf+P+2iVfDvxhc= liam@DESKTOP-BL38KQK"
    ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
  nix.settings.allowed-users = ["${username}"];
}
