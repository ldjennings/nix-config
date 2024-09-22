{ pkgs, ... }:

{
  programs.vscode =
  {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false; 

    package = pkgs.vscodium;
  
    extensions = with pkgs.vscode-extensions; [
      usernamehw.errorlens
      llvm-vs-code-extensions.vscode-clangd
      jnoortheen.nix-ide

      # ms-vscode.cpptools
      redhat.java
      vscjava.vscode-java-debug

      rust-lang.rust-analyzer
      bungcip.better-toml

      ms-python.python
      # ms-python.vscode-pylance
    ];
  
    userSettings = {
      "window.titleBarStyle" = "custom";
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 100;
      "clangd.path" = "/home/liam/.config/VSCodium/User/globalStorage/llvm-vs-code-extensions.vscode-clangd/install/18.1.3/clangd_18.1.3/bin/clangd";
    };
  };
}