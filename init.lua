-- Configuration file for Neovim
-- Author: AlexanderRichey (alrichey@)


-- Utility Functions
-------------------------------------------------------------------------------

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function bufmap(bufn, mode, shortcut, command)
  vim.api.nvim_buf_set_keymap(bufn, mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function nbufmap(bufn, shortcut, command)
  bufmap(bufn, 'n', shortcut, command)
end


-- Packer
-------------------------------------------------------------------------------

-- Install Packer:
--
--   git clone --depth 1 https://github.com/wbthomason/packer.nvim\
--     ~/.local/share/nvim/site/pack/packer/start/packer.nvim
--


-- Plugins
-------------------------------------------------------------------------------

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- file browser
  use 'tpope/vim-vinegar'

  -- comment in/out code
  use 'tpope/vim-commentary'

  -- surround characters shortcuts
  use 'tpope/vim-surround'

  -- tmux support
  use {
    'aserowy/tmux.nvim',
    config = function()
      require("tmux").setup({
          navigation = {
              -- enables default keybindings (C-hjkl) for normal mode
              enable_default_keybindings = true,
          },
          resize = {
              -- enables default keybindings (A-hjkl) for normal mode
              enable_default_keybindings = true,
          }
      })
    end
  }

  -- language pack
  use 'sheerun/vim-polyglot'

  -- theme
  use 'Th3Whit3Wolf/one-nvim'

  -- fuzzy finder, etc.
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},  -- lua-based pop window
      {'nvim-lua/plenary.nvim'}  -- lua functions, dependency of many plugins
    },
    config = function()
      require('telescope').setup{
        defaults = {
          file_ignore_patterns = {
            "node_modules",
            "build",
            "public",
            "tmp",
            "lang",
          },
        },
      }

      -- Map find_files to ctrl-p
      nmap("<C-p>", "<cmd>Telescope find_files<cr>")

      -- Map live_grep to \-f
      nmap("<leader>f", "<cmd>Telescope live_grep<cr>")
    end
  }

  -- show git diff
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup{} end
  }

  -- multicursor
  use {
    'mg979/vim-visual-multi',
    branch = 'master'
  }

  -- info line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      -- see config below
    end
  }

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    config = function()
      -- see config below
    end
  }

  -- lsp installer
  use {
    'williamboman/nvim-lsp-installer',
    config = function()
      -- see more config below
    end
  }

  -- autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      -- see config below
    end
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup{
        ensure_installed = {
          "go",
          "javascript",
          "typescript",
          "python",
        },
        highlight = {
          enable = false,
          additional_vim_regex_highlighting = false,
        },
      }
    end
  }

  -- autoclose pairs
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{
        enable_check_bracket_line = false,
      }
    end
  }

  -- prose mode
  use 'reedes/vim-pencil'

  -- linting
  use 'w0rp/ale'
end)


-- Standard Settings
-------------------------------------------------------------------------------

-- copy indents when starting new lines
vim.opt.autoindent = true

-- softabs
vim.opt.expandtab = true

-- tab width is 2 spaces by default
vim.opt.tabstop = 2

-- autoindent with 2 spaces
vim.opt.shiftwidth = 2

-- show line numbers
vim.opt.number = true

-- show relative line numbers
vim.opt.relativenumber = true

-- highlight current line number
vim.opt.number = true

-- highlight matching parenthesis
vim.opt.showmatch = true

-- highlight current line
vim.opt.cursorline = true

-- always show four lines around the cursor
vim.opt.scrolloff = 4

-- disable folds
vim.opt.fen = false

-- auto reload files changed outside of vim
vim.opt.autoread = true

-- allow backspacing over everything in insert mode
vim.opt.backspace = 'indent,eol,start'

-- do not wait for key combos
vim.opt.timeout = false

-- disable swapfile
vim.opt.swapfile = false

-- no annoying and pointless bells and flashes
vim.opt.belloff = 'all'

-- always show signcolumns
vim.opt.signcolumn = 'yes'

-- disable documentation opening up spontaneously
vim.opt.completeopt = 'menuone,noselect'

-- resolve gf, gd to these dirs
vim.opt.path = '.,src,src/shared,node_nodules'

-- resovle gf, gd to these extensions
vim.opt.suffixesadd = '.js,.jsx'


-- Wild
-------------------------------------------------------------------------------

-- enhance command line completion
vim.opt.wildmenu = true

-- list all options, match to the longest
vim.opt.wildmode = 'list:longest,full'

-- ignore list
vim.opt.wildignore = '*/node_modules/*,*.so,*.swp,*.zip,*.pyc,*.git,*/env/*,tags,build,tmp/'


-- Theming
-------------------------------------------------------------------------------

-- enable colors
vim.opt.termguicolors = true

-- set the theme
vim.cmd('colorscheme one-nvim')

-- set the variant
vim.opt.background = 'dark'


-- lualine
-------------------------------------------------------------------------------

require'lualine'.setup{
  options = {
    theme = 'onedark',
    icons_enabled = false,
    component_separators = {'', ''},
    section_separators = {'', ''},
  },
}


-- ALE
-------------------------------------------------------------------------------

vim.cmd([[
  " lint
  let g:ale_enabled=1
  let g:ale_linters = {
  \  'javascript': ['eslint'],
  \  'javascriptreact': ['eslint'],
  \  'python': ['black'],
  \  'html': ['prettier'],
  \  'go': ['golangci-lint'],
  \  'java': [],
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
  let g:ale_completion_enabled = 0 " use cmp instead
]])


-- nvim-cmp
-------------------------------------------------------------------------------

local cmp = require'cmp'
local luasnip = require'luasnip'
local lspinstaller = require'nvim-lsp-installer'
local lspconfig = require'lspconfig'

-- setup
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  window = {},
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- use cmdline and path source for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- configure lspconfig with installed lsps
lspinstaller.setup()

local default_on_attach = function(_, bufn)
  nbufmap(bufn, 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  nbufmap(bufn, 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  nbufmap(bufn, 'K', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  nbufmap(bufn, 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  nbufmap(bufn, '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  nbufmap(bufn, '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  nbufmap(bufn, '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  nbufmap(bufn, 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  nbufmap(bufn, '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
  nbufmap(bufn, '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
end

for _, server in ipairs(lspinstaller.get_installed_servers()) do
  if server.name == 'jdtls' then
    local ws_folders_lsp = {}
    local ws_folders_jdtls = {}
    local file = io.open("../../.bemol/ws_root_folders", "r");
    if file then
      for line in file:lines() do
        table.insert(ws_folders_lsp, line);
        table.insert(ws_folders_jdtls, string.format("file://%s", line))
      end
      file:close()
    end

    lspconfig[server.name].setup{
      on_attach = function(_, bufn)
        for _,line in ipairs(ws_folders_lsp) do
          vim.lsp.buf.add_workspace_folder(line)
        end

        default_on_attach(_, bufn)
      end,

      init_options = {
        workspaceFolders = ws_folders_jdtls
      },

      flags = {
        debounce_text_changes = 150,
      },

      capabilities = require'cmp_nvim_lsp'.update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      )
    }
  else
    lspconfig[server.name].setup{
      on_attach = default_on_attach,

      flags = {
        debounce_text_changes = 150,
      },

      capabilities = require'cmp_nvim_lsp'.update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      )
    }
  end
end

-- integrate autopairs
cmp.event:on('confirm_done',
  require'nvim-autopairs.completion.cmp'.on_confirm_done({
      map_char = { tex = '' }
  })
)


-- Language Overrides
-------------------------------------------------------------------------------

-- python
vim.cmd([[
  autocmd Filetype python setlocal
    \ shiftwidth=4
    \ tabstop=4
    \ softtabstop=4
    \ expandtab
    \ autoindent
]])

-- go
vim.cmd([[
  autocmd Filetype go setlocal
    \ shiftwidth=6
    \ tabstop=6
    \ noexpandtab
    \ autoindent
]])
