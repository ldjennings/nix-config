{ lib, pkgs, ... }:

{
  home.packages = with pkgs.gnomeExtensions;
  [
    kimpanel
    clipboard-indicator
    wallpaper-slideshow
  ];

  dconf.settings =
  {

    "org/gnome/shell" =
    {
      disable-user-extensions = false;

      enabled-extensions =
      [
    	pkgs.gnomeExtensions.kimpanel.extensionUuid	
    	pkgs.gnomeExtensions.clipboard-indicator.extensionUuid
    	pkgs.gnomeExtensions.wallpaper-slideshow.extensionUuid	
      ];
    };

    "org/gnome/shell/extensions/clipboard-indicator" =
    {
      move-item-first = true; # Move to top of the list when selected
      
      enable-keybindings = false;
      history-size = 30;
    };
    "org/gnome/shell/extensions/azwallpaper" = # wallpaper slideshow
    {
      slideshow-directory="/home/liam/nix-config/resources";

      slideshow-slide-duration = lib.hm.gvariant.mkTuple [ 0 0 10 ];

      slideshow-use-absolute-time-for-duration=true;
    };
  };
}
