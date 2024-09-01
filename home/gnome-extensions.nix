{ pkgs, ... }:

{

  home.packages = with pkgs.gnomeExtensions;
  [
    kimpanel
    clipboard-indicator
    wallhub
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
	pkgs.gnomeExtensions.wallhub.extensionUuid	
      ];
    };

    "org/gnome/shell/extensions/clipboard-indicator" =
    {
      move-item-first = true; # Move to top of the list when selected
      
      enable-keybindings = false;
      history-size = 30;
    };
  };
}
