{ lib, config, pkgs, ... }:

{
  home.username = "liam";
  home.homeDirectory = "/home/liam";

    imports =
    [
      (import ./user-packages.nix {
       inherit pkgs;
      }) 
      ./dconf.nix 
      ./shell.nix	 
      (import ./gnome-extensions.nix {
        inherit pkgs;
        inherit lib;
       })
      (import ./vim.nix {
        inherit pkgs;
      })
   ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "ldjennings";
    userEmail = "jenningsliamd@gmail.com";
    extraConfig = {
      core.editor = "vim";
      help.autocorrect = 30;
    };
  };

  programs.vscode =
  {
    enable = true;
 #   enableUpdateCheck = false;
 #   enableExtensionUpdateCheck = false;
    
    extensions = with pkgs.vscode-extensions; [
      usernamehw.errorlens
      llvm-vs-code-extensions.vscode-clangd
#      platformio.platformio-ide
    ];
  
    userSettings = {
  #    "window.titleBarStyle" = "custom";
  #    "files.autoSave" = "afterDelay";
    };
  };

  # home.sessionVariables.VLC_PLUGIN_PATH = "${pkgs.vlc-bittorrent}";
  # programs.vlc-bittorrent.enable= true;

 


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
