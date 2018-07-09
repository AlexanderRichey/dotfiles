""""""" Plugin management stuff """""""
" vim-plug hook functions
function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.sh
  endif
endfunction

call plug#begin('~/.config/nvim/plugged')

" Tmux support
Plug 'christoomey/vim-tmux-navigator'
" Autocompletion
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
" Airline
Plug 'vim-airline/vim-airline'
" Tree file browser
Plug 'tpope/vim-vinegar'
" ag search
Plug 'rking/ag.vim'
" Fuzzy finder
Plug 'kien/ctrlp.vim'
" Multicursor
Plug 'terryma/vim-multiple-cursors'
" Javascrip + React
Plug 'pangloss/vim-javascript'
Plug 'chemzqm/vim-jsx-improve'
" Linting
Plug 'w0rp/ale'
" Comments
Plug 'tpope/vim-commentary'
" Git
Plug 'airblade/vim-gitgutter'
" Colors
Plug 'rakr/vim-one'

call plug#end()

""""""" General config """""
set expandtab " use softtabs
set number " show line numbers
set relativenumber " show relative line numbers
set showmatch " highlight matching parenthesis
set cursorline " highlight current line
set wildignore=*/node_modules/*,*.so,*.swp,*.zip,*.pyc,*.git,*/env/*
set noswapfile
set nofoldenable
set shiftwidth=2
set softtabstop=2
set tabstop=2

""""""" Theme """"""""""""""
set termguicolors
colorscheme one
set background=dark
let g:one_allow_italics = 1

""""""" Python config """"""
syntax enable
set number showmatch
autocmd Filetype python setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent
let python_highlight_all = 1
set completeopt=menu " disable documentation opening up spontaneously

""""""" ALE config """"""""""
let g:ale_use_deprecated_neovim = 1
let g:ale_linters = {'javascript': ['standard'], 'python': ['pycodestyle --max-line-length 90']}

""""""" NERDTree config """"
nnoremap C :bp\|bd #<CR>
let NERDTreeIgnore = ['\.pyc$', 'env', 'node_modules']
let NERDTreeShowHidden = 1
