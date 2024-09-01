{ ... }:
{
  dconf.settings =
  {
    "org/gnome/shell" =
    {
      favorite-apps = # Taskbar apps
      [
        "firefox.desktop"
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

  };
}
