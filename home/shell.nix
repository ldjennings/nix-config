{ ...  }:

let
  # Use absolute paths or expand home directory correctly
  celeste_path = "/home/liam/Documents/celeste-linux/Celeste";
  obsidian_dir = "/home/liam/obsidian";
  cubemx_path  = "/home/liam/STM32CubeMX/STM32CubeMX";
in
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

          # Use the path variables
          celeste = "${celeste_path}";

          synco = "cd ${obsidian_dir} && git add -v . && git commit -m 'automatic laptop commit' && git push; cd - > /dev/null";
          pullo = "cd ${obsidian_dir} && git pull; cd - > /dev/null";
          stm32cubemx = "steam-run ${cubemx_path}";
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
