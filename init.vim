" Configuration file for vim & nvim
" author: AlexanderRichey (alrichey@)

" Vim-Plug
call plug#begin('~/.vim/plugged')
  Plug 'nvim-lua/plenary.nvim'                               " lua functions, dependency of modern plugins
  Plug 'nvim-lua/popup.nvim'
  Plug 'tpope/vim-vinegar'                                   " file browser
  Plug 'tpope/vim-commentary'                                " comment in/out code
  Plug 'windwp/nvim-autopairs'                               " autoclose pairs
  Plug 'aserowy/tmux.nvim'                                   " tmux support
  Plug 'neovim/nvim-lspconfig'                               " lsp support
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'hrsh7th/nvim-compe'                                  " autocomplete
  Plug 'hoob3rt/lualine.nvim'                                " info line
  Plug 'rking/ag.vim'                                        " better search with :Ag
  Plug 'kien/ctrlp.vim'                                      " fuzzy finder
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}        " multicursor
  Plug 'lewis6991/gitsigns.nvim'                             " show git diff
  Plug 'reedes/vim-pencil'                                   " prose mode
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } " md preview
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }        " fzf
  " Languages
  Plug 'sheerun/vim-polyglot'
  " Linting
  Plug 'w0rp/ale'
  " Themes
  Plug 'rakr/vim-one'
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
set completeopt=menuone,noselect " disable documentation opening up spontaneously
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

" Terminal
  " set default command
  let &shell='/bin/bash --login'
  " esc works in term pane
  tnoremap <Esc> <C-\><C-n>

" Plugin configurations
  " lualine
lua << EOF
require'lualine'.setup {
  options = {theme = 'onedark'}
}
EOF

  " gitsigns
lua << EOF
require'gitsigns'.setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}
EOF

  " autopairs
lua << EOF
require "nvim-autopairs".setup()
EOF

  " tmux
lua << EOF
require "tmux".setup {
  navigation = {
      -- enables default keybindings (C-hjkl) for normal mode
      enable_default_keybindings = true,
  },
  resize = {
      -- enables default keybindings (A-hjkl) for normal mode
      enable_default_keybindings = true,
  }
}
EOF

  " lspconfig
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'gopls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

  " compe
lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

--Use tab to navigate completion menu
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

-- Map tab to the above tab complete functiones
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- Map compe confirm and complete functions
vim.api.nvim_set_keymap('i', '<CR>', "compe#confirm(luaeval(\"require 'nvim-autopairs'.autopairs_cr()\"))", { expr = true })
vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<C-e>', 'compe#close("<C-e>")', { expr = true })
EOF

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
    " vim-go
    let g:go_code_completion_enabled = 0
