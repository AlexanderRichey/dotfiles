set nocompatible              " be iMproved, required by vundle
filetype off                  " required by vundle

syntax enable

set expandtab " use softtabs
set number " show line numbers
set relativenumber " show relative line numbers
set showmatch " highlight matching parenthesis
set cursorline " highlight current line
set wildignore=*/node_modules/*,*.so,*.swp,*.zip,*.pyc,*.git,*/env/*
set backupcopy=yes
set noswapfile
set nofoldenable
set shiftwidth=2
set softtabstop=2
set tabstop=2
set clipboard=unnamed
set completeopt=menu " disable documentation opening up spontaneously
set termguicolors

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'pangloss/vim-javascript'
Plugin 'chemzqm/vim-jsx-improve'
Plugin 'nvie/vim-flake8'
Plugin 'valloric/youcompleteme'


" Colors
Plugin 'rakr/vim-one'
Plugin 'joshdick/onedark.vim'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()            " required
filetype plugin indent on    " required

syntax on
colorscheme onedark

" Open NERDTree on enter
au VimEnter *  NERDTree

" C does not cause NERDTree to take over
nnoremap C :bp\|bd #<CR>

let NERDTreeIgnore = ['\.pyc$', 'env', 'node_modules']

" Set 4 space tab for python
autocmd Filetype python setlocal ts=4 sw=4 sts=0 expandtab

let g:pymode_doc = 0

