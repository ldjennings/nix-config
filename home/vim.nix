{ pkgs, ... }:

{

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline vim-visual-multi];
    settings = { ignorecase = true; };
    extraConfig = ''
      " tab controls
      set expandtab
      set tabstop=4
      set shiftwidth=4

      " relative line numbers
      set relativenumber

      " Syntax highlighting
      syntax on

      " autoindent
      set smartindent

      " Search Settings
      set hlsearch
      set smartcase
    '';
  };
}
