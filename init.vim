""""""" Plugin management stuff """""""
call plug#begin('~/.config/nvim/plugged')

" Tmux support
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
" Autocompletion
Plug 'Valloric/YouCompleteMe'
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
Plug 'hashivim/vim-terraform'
" Linting
Plug 'w0rp/ale'
Plug 'ambv/black'
" Comments
Plug 'tpope/vim-commentary'
" Git
Plug 'airblade/vim-gitgutter'
" Colors
Plug 'joshdick/onedark.vim'
" Prose mode
Plug 'reedes/vim-pencil'

call plug#end()

""""""" General config """""
syntax enable
syntax on
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
set number showmatch
set autoread

""""""" Theme """"""""""""""
set termguicolors
let g:onedark_termcolors=256
let g:airline_theme='onedark'
colorscheme onedark
call onedark#set_highlight("Normal", { "fg": { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" } })

""""""" ALE config """"""""""
" let g:ale_use_deprecated_neovim = 1
let g:ale_enabled=1
let g:ale_linters = {
\  'javascript': ['standard'],
\  'python': ['pycodestyle --max-line-length 90', 'black'],
\}

""""""" Python config """"""
autocmd Filetype python setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent
let python_highlight_all = 1
set completeopt=menu " disable documentation opening up spontaneously
autocmd BufWritePre *.py execute ':Black'
