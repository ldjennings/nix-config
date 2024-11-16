{ lib, ... }:
{
  dconf.settings =
  {
    "org/gnome/shell" =
    {
      favorite-apps = # Taskbar apps
      [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "obsidian.desktop"
    	  "codium.desktop"
       ];
    };
    "org/gnome/settings-daemon/peripherals/keyboard" =
    {
      bell-mode = "off";
    }; 
    "org/gnome/desktop/interface" =
    {
      color-scheme = "prefer-dark";

      clock-format = "12h";
      clock-show-weekday = true; # Show day of the week on top bar
      clock-show-date = false; # Don't show the date


      font-antialiasing = "rgba"; # Aliasing with lcd screen instead of grayscale

    };

    "org/gnome/desktop/wm/preferences" =
    {
      button-layout = "appmenu:minimize,close"; # Show minimize and close button for windows
    };

    "org/gnome/mutter" =
    {
      edge-tiling = true;
    };

    "org/gnome/desktop/peripherals/touchpad" =
    { 
      speed = lib.hm.gvariant.mkDouble 0.38461538461538458;
    };

    "org/gnome/desktop/privacy" =
    {
      remove-old-temp-files = true;
      recent-files-max-age = 30;

      remove-old-trash-files = true;
      old-files-age = 30;
    };

    "org/gnome/mutter/wayland/keybindings" =
    {
      restore-shortcuts = []; # Never reset shortcuts to default
    };

    "org/gnome/desktop/wm/keybindings" =
    {
      switch-applications = [ "<Super>Tab" ];
      switch-applications-backward = [ "<Shift><Super>Tab" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];


      toggle-fullscreen = ["F11"];
      lower = ["<Super>Down"]; # Lower window
    };

    "org/gnome/settings-daemon/plugins/media-keys" =
    {
      screenreader = [];

      home = ["<Super>e"]; # Open file explorer
      www = ["<Super>f"]; # Open web browser
      control-center = ["<Super>i"]; # Open settings

      logout = ["<Control><Alt>BackSpace"]; # Power off

      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ]; # List of custom keybindings
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
    {
      binding = "<Super>t";
      command = "gnome-terminal";
      name = "Open Terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" =
    {
      binding = "<Control><Alt>Delete";
      command = "nix run nixpkgs#resources";
      name = "Open Resources app to force quit applications";
    };

    "org/gnome/desktop/interface" = {
      text-scaling-factor = 1.4000000000000004;
    };
  };
}
