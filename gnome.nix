{
  pkgs,
  ...
}:

{
  # Enable the GNOME Desktop Environment.
  services = {
    xserver = {
      enable = true;
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [pkgs.gnome.mutter];
        extraGSettingsOverrides = ''
          [org.gnome.mutter]
	  experimental-features=['scale-monitor-framebuffer']
        '';
      };
      displayManager.gdm.enable = true;
    };
  };

    services.gnome =
    {
      core-utilities.enable = false;
    };

    environment.gnome.excludePackages = with pkgs;
    [
      gnome-tour
    ];

    # Add some actually useful packages back
    environment.systemPackages = with pkgs;
    [
      gnome-extension-manager
    ]
    ++
    (with pkgs.gnome;
    [
      gnome-tweaks
      nautilus
      gnome-terminal
      gnome-disk-utility
      resources
    ]
    );


}
