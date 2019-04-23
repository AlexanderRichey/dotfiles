" Configuration file for vim & nvim
" author: AlexanderRichey (alrichey@)

" Vim-Plug
call plug#begin('~/.vim/plugged')
  Plug 'christoomey/vim-tmux-navigator'                      " tmux support
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} " autocompletion & linting
  Plug 'itchyny/lightline.vim'                               " info line
  Plug 'tpope/vim-vinegar'                                   " file browser
  Plug 'tpope/vim-commentary'                                " comment in/out code
  Plug 'rking/ag.vim'                                        " better search with :Ag
  Plug 'kien/ctrlp.vim'                                      " fuzzy finder
  Plug 'terryma/vim-multiple-cursors'                        " multicursor
  Plug 'mhinz/vim-signify'                                   " show git diff
  Plug 'reedes/vim-pencil'                                   " prose mode
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } " md preview
  " Languages
  Plug 'pangloss/vim-javascript'                             " js
  Plug 'chemzqm/vim-jsx-improve'                             " jsx
  Plug 'hashivim/vim-terraform'                              " terraform
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }         " go
  " Linting
  Plug 'w0rp/ale'
  " Plug 'ambv/black'                                        " slows start time
  " Themes
  Plug 'joshdick/onedark.vim'
call plug#end()

" Standard vim options
set nocompatible             " use vim instead of vi defaults
set autoindent               " copy indents when starting new lines
set expandtab                " softabs
set tabstop=2                " tab width is 2 spaces by default
set shiftwidth=2             " autoindent with 2 spaces
set number                   " show line numbers
set relativenumber           " show relative line numbers
set number showmatch         " highlight current line number
set showmatch                " highlight matching parenthesis
set cursorline               " highlight current line
set scrolloff=1              " always show one line around the cursor
set nofen                    " disable folds
set autoread                 " auto reload files changed outside of vim
set backspace=2              " allow backspacing over everything in insert mode
set notimeout                " do not wait for key combos
set noswapfile               " disable swapfile
set completeopt=menu         " disable documentation opening up spontaneously

" Wild
set wildmenu                   " enhance command line completion
set wildmode=list:longest,full " list all options, match to the longest
set wildignore=*/node_modules/*,*.so,*.swp,*.zip,*.pyc,*.git,*/env/*,build/

" Theming
  "turn on syntax highlighting
  syntax on

  " onedark.vim override: Don't set a background color when running in a terminal;
  " just use the terminal's background color
  " `gui` is the hex color code used in GUI mode/nvim true-color mode
  " `cterm` is the color code used in 256-color mode
  " `cterm16` is the color code used in 16-color mode
  if (has("autocmd") && !has("gui_running"))
    augroup colorset
      autocmd!
      let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
      " `bg` will not be styled since there is no `bg` setting
      autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) 
    augroup END
    " highlight CursorLine ctermbg=235
  endif

  " set the theme
  colorscheme onedark

" Terminal
  " set default command
  let &shell='/bin/bash --login'
  " esc works in term pane
  tnoremap <Esc> <C-\><C-n>

" Plugin configurations
  " ale
    " lint
    let g:ale_enabled=1
    let g:ale_linters = {
    \  'javascript': ['prettier'],
    \  'python': ['black'],
    \  'html': ['prettier'],
    \  'go': ['golint'],
    \}
    " fix
    let g:ale_fix_on_save=1
    let g:ale_fixers = {
    \  'javascript': ['prettier'],
    \  'html': ['prettier'],
    \  'go': ['gofmt'],
    \}
    " complete
    let g:ale_completion_enabled = 0 " use coc instead

  " coc autocomplete
    " use <tab> for trigger completion and navigate to next complete item
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()

" Language overrides
  " python
    " use 4 spaces
    autocmd Filetype python setlocal 
      \ shiftwidth=4 
      \ tabstop=4 
      \ softtabstop=4 
      \ expandtab 
      \ autoindent
    " Run black after every save
    autocmd BufWritePre *.py execute ':Black'

  " go
    " use tabs
    autocmd Filetype go setlocal 
      \ shiftwidth=4
      \ tabstop=4 
      \ noexpandtab 
      \ autoindent
