""""""" Plugin management stuff """""""
call plug#begin('~/.vim/plugged')

" Tmux support
Plug 'christoomey/vim-tmux-navigator'
" Plug 'tmux-plugins/vim-tmux-focus-events'
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
Plug 'rakr/vim-one'
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
set backspace=indent,eol,start

""""""" Theme """"""""""""""

" onedark.vim override: Don't set a background color when running in a terminal;
" just use the terminal's background color
" `gui` is the hex color code used in GUI mode/nvim true-color mode
" `cterm` is the color code used in 256-color mode
" `cterm16` is the color code used in 16-color mode
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
  highlight CursorLine ctermbg=235
endif

colorscheme onedark

""""""" :terminal config """"
let &shell='/bin/bash --login'
tnoremap <Esc> <C-\><C-n>

""""""" ALE config """"""""""
let g:ale_enabled=1
let g:ale_linters = {
\  'javascript': ['prettier'],
\  'python': ['black'],
\}

let g:ale_fix_on_save=1
let g:ale_fixers = {
\  'javascript': ['prettier'],
\}

""""""" Python config """"""
autocmd Filetype python setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent
let python_highlight_all = 1
set completeopt=menu " disable documentation opening up spontaneously
autocmd BufWritePre *.py execute ':Black'
