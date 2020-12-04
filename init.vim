" Configuration file for vim & nvim
" author: AlexanderRichey (alrichey@)

" Vim-Plug
call plug#begin('~/.vim/plugged')
  Plug 'christoomey/vim-tmux-navigator'                      " tmux support
  Plug 'neoclide/coc.nvim', {'branch': 'release'}            " autocompletion & linting
  Plug 'itchyny/lightline.vim'                               " info line
  Plug 'tpope/vim-vinegar'                                   " file browser
  Plug 'tpope/vim-commentary'                                " comment in/out code
  Plug 'rking/ag.vim'                                        " better search with :Ag
  Plug 'kien/ctrlp.vim'                                      " fuzzy finder
  Plug 'terryma/vim-multiple-cursors'                        " multicursor
  Plug 'mhinz/vim-signify'                                   " show git diff
  Plug 'reedes/vim-pencil'                                   " prose mode
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } " md preview
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }        " fzf
  " Languages
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'sheerun/vim-polyglot'
  " Linting
  Plug 'w0rp/ale'
  " Themes
  Plug 'rakr/vim-one'
  Plug 'NovaDev94/lightline-onedark'
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
set scrolloff=4              " always show one line around the cursor
set nofen                    " disable folds
set autoread                 " auto reload files changed outside of vim
set backspace=2              " allow backspacing over everything in insert mode
set notimeout                " do not wait for key combos
set noswapfile               " disable swapfile
set belloff=all              " no annoying and pointless bells and flashes
set signcolumn=yes           " always show signcolumns
set completeopt=menu         " disable documentation opening up spontaneously
set path=.,src,src/shared,node_nodules " resolve gf, gd to these dirs
set suffixesadd=.js,.jsx     " resovle gf, gd to these extensions

" Wild
set wildmenu                   " enhance command line completion
set wildmode=list:longest,full " list all options, match to the longest
set wildignore=*/node_modules/*,*.so,*.swp,*.zip,*.pyc,*.git,*/env/*,build/

" Theming
  "turn on syntax highlighting
  syntax on

  " 24-bit Color
  if (has("termguicolors"))
    set termguicolors
  endif

  " set the theme
  colorscheme one

  " tweaks
  set background=dark
  let g:one_allow_italics=1

  " lightline
  let g:lightline = {
  \ 'colorscheme': 'onedark'
  \}

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
    \  'javascriptreact': ['prettier'],
    \  'python': ['black'],
    \  'html': ['prettier'],
    \  'go': ['golangci-lint'],
    \}
    " fix
    let g:ale_fix_on_save=1
    let g:ale_fixers = {
    \  'javascript': ['prettier'],
    \  'javascriptreact': ['prettier'],
    \  'python': ['black'],
    \  'json': ['prettier'],
    \  'yaml': ['prettier'],
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

  " go
    " use tabs
    autocmd Filetype go setlocal 
      \ shiftwidth=6
      \ tabstop=6
      \ noexpandtab 
      \ autoindent
    " pretty colors
    let g:go_highlight_structs = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
