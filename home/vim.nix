{ pkgs, ... }:

{

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline ];
    settings = { ignorecase = true; };
    extraConfig = ''
	set expandtab
	set tabstop=4
	set shiftwidth=4
    '';
  };
}
