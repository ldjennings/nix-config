{ pkgs, ... }:

{
  programs.vscode =
  {
    enable = true;
    enableUpdateCheck = false;
    
    mutableExtensionsDir = false;
    enableExtensionUpdateCheck = false; 

    package = pkgs.vscodium;

    extensions = with pkgs.vscode-extensions; [
      eamodio.gitlens
      usernamehw.errorlens
      wix.vscode-import-cost
      gruntfuggly.todo-tree
      # pflannery.vscode-versionlens

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
      "editor.inlineSuggest.enabled" = true;


      "window.titleBarStyle" = "custom";
      "files.autoSave" = "afterDelay";

      "files.autoSaveDelay" = 100;
      "clangd.path" = "${pkgs.clang-tools}/bin/clangd";
      "errorLens.gutterIconsEnabled" = true;
      

      "git.autofetch" = true;
      "git.confirmSync" = false;
      "git.enableCommitSigning" = true;

      "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
      "nix.enableLanguageServer" = true;
      "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
      "nix.serverPath" = "${pkgs.nil}/bin/nil";
      "nix.serverSettings"."nil"."formatting"."command" = ["${pkgs.alejandra}/bin/alejandra"];

      "todo-tree.general.statusBar" = "total";
      "todo-tree.highlights.highlightDelay" = 0;
      "todo-tree.highlights.customHighlight.TODO.type" = "text";
      "todo-tree.highlights.customHighlight.TODO.foreground" = "black";
      "todo-tree.highlights.customHighlight.TODO.background" = "green";
      "todo-tree.highlights.customHighlight.TODO.iconColour" = "green";
      "todo-tree.highlights.customHighlight.TODO.icon" = "shield-check";
      "todo-tree.highlights.customHighlight.TODO.gutterIcon" = true;
      "todo-tree.highlights.customHighlight.FIXME.type" = "text";
      "todo-tree.highlights.customHighlight.FIXME.foreground" = "black";
      "todo-tree.highlights.customHighlight.FIXME.background" = "yellow";
      "todo-tree.highlights.customHighlight.FIXME.iconColour" = "yellow";
      "todo-tree.highlights.customHighlight.FIXME.icon" = "shield";
      "todo-tree.highlights.customHighlight.FIXME.gutterIcon" = true;
      "todo-tree.highlights.customHighlight.HACK.type" = "text";
      "todo-tree.highlights.customHighlight.HACK.foreground" = "black";
      "todo-tree.highlights.customHighlight.HACK.background" = "red";
      "todo-tree.highlights.customHighlight.HACK.iconColour" = "red";
      "todo-tree.highlights.customHighlight.HACK.icon" = "shield-x";
      "todo-tree.highlights.customHighlight.HACK.gutterIcon" = true;
      "todo-tree.highlights.customHighlight.BUG.type" = "text";
      "todo-tree.highlights.customHighlight.BUG.foreground" = "black";
      "todo-tree.highlights.customHighlight.BUG.background" = "orange";
      "todo-tree.highlights.customHighlight.BUG.iconColour" = "orange";
      "todo-tree.highlights.customHighlight.BUG.icon" = "bug";
      "todo-tree.highlights.customHighlight.BUG.gutterIcon" = true;

    };
  };
}