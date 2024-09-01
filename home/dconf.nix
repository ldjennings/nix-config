{ ... }:
{
  dconf.settings =
  {
    "org/gnome/shell" =
    {
      favorite-apps = # Taskbar apps
      [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Terminal.desktop"
       ];
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

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
    {
      binding = "<Control>t";
      command = "gnome-terminal";
      name = "Open Resources app to force quit applications";
    };

  };
}
