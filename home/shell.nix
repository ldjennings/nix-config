{ ...  }:

{

  programs = {
    zsh = {
      enable = true;
      
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "sudo"
          "systemadmin"
        ];
      };
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      autocd = true;


      sessionVariables =
      {
        EDITOR = "vim";
      };

      history =
      {
        share = true; # Share history between terminal sessions
        ignoreDups = true; # # Ignore duplicates only if they're right next to each other
      };
    };
  };
}
