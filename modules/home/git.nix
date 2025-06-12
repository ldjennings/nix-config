{host, ...}: let
  inherit (import ../../hosts/${host}/variables.nix) gitUsername gitEmail;
in {
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";

    extraConfig.init.defaultBranch = "main";

    extraConfig.core.editor = "vim";

    extraConfig.pull.rebase = true;

    extraConfig.merge.conflictStyle = "diff3";

    extraConfig.diff.colorMoved = "default";

    extraConfig.color.ui = "auto";

    extraConfig.pull.ff = "only";
  };
}
