{ ...  }:

{

  programs = {
    zsh = {
      enable = true;
      
      ohMyZsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "sudo"
          "systemadmin"
        ];
      };
     # autosuggestion.enable = true;
     # syntaxHighlighting.enable = true;

     # autocd = true;

       shellAliases = {
          gav = "git add . -v";
          gpl = "git pull";
          gc = "git commit";
          gp = "git push";
          gs = "git status";
          gsv = "git status -v";
          gd = "git diff";
          gl = "git log";
          dotcommit = "git add . && git commit -m '.'";

         # treasure = "sudo docker run --privileged -v ${PWD}:/root/host-share --rm -it --workdir=/root rjwalls/epictreasure tmux";


        };


     # sessionVariables =
     # {
     #   EDITOR = "vim";
     # };

     # history =
     # {
     #   share = true; # Share history between terminal sessions
     #   ignoreDups = true; # # Ignore duplicates only if they're right next to each other
     # };
    };
  };
}

