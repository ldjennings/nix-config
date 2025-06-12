{host, ...}: {
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
      syntaxHighlighting = {
        enable = true;
        highlighters = ["main" "brackets" "pattern" "regexp" "root" "line"];
      };
      historySubstringSearch.enable = true;

      history = {
        ignoreDups = true;
        save = 10000;
        size = 10000;
      };

      autocd = true;

      shellAliases = {
        sv = "sudo nvim";
        v = "nvim";
        c = "clear";
        fr = "nh os switch --hostname ${host}";
        fu = "nh os switch --hostname ${host} --update";
        ft = "nh os test --hostname ${host}";
        ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
        cat = "bat";
        man = "batman";
        ls = "eza --icons --group-directories-first -1";
        ll = "eza --icons -lh --group-directories-first -1 --no-user --long";
        la = "eza --icons -lah --group-directories-first -1";
        tree = "eza --icons --tree --group-directories-first";
      };

      # sessionVariables =
      # {
      #   EDITOR = "vim";
      # };
    };
  };
}
