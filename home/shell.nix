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

      shellAliases =
      {
	gav = "git add . -v";
        gpl = "git pull";
	gc = "git commit";
        gp = "git push";
        gs = "git status";
        gsv = "git status -v";

      };

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
