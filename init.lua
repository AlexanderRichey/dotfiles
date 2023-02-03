-- Configuration file for Neovim
-- Author: AlexanderRichey (alrichey@)


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

  use {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').load()
    end
  }

  -- fuzzy finder, etc.
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/popup.nvim' }, -- lua-based pop window
      { 'nvim-lua/plenary.nvim' } -- lua functions, dependency of many plugins
    },
    config = function()
      require('telescope').setup {
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
      vim.api.nvim_set_keymap('n', "<C-p>", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })

      -- Map live_grep to \-f
      vim.api.nvim_set_keymap('n', "<leader>f", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
    end
  }

  -- show git diff
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup {} end
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

  -- lsp installer
  use {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  }

  -- lsp installer
  use {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup()
    end
  }

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    config = function()
      -- see config below
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
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          "go",
          "javascript",
          "typescript",
          "python",
          "java",
          "kotlin",
          "bash",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end
  }

  -- autoclose pairs
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {
        enable_check_bracket_line = false,
      }
    end
  }

  -- prose mode
  use 'reedes/vim-pencil'
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

-- disable mouse mode
vim.opt.mouse = ""

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


-- lualine
-------------------------------------------------------------------------------

require 'lualine'.setup {
  options = {
    theme = 'onedark',
  },
}


-- nvim-cmp
-------------------------------------------------------------------------------

local cmp = require 'cmp'
local luasnip = require 'luasnip'
local masonlspconfig = require 'mason-lspconfig'
local lspconfig = require 'lspconfig'

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

-- setup lsps
local default_on_attach = function(_, bufn)
  local options = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufn, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
  vim.api.nvim_buf_set_keymap(bufn, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', options)
  vim.api.nvim_buf_set_keymap(bufn, 'n', 'K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)
  vim.api.nvim_buf_set_keymap(bufn, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
  vim.api.nvim_buf_set_keymap(bufn, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', options)
  vim.api.nvim_buf_set_keymap(bufn, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', options)
  vim.api.nvim_buf_set_keymap(bufn, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', options)
  vim.api.nvim_buf_set_keymap(bufn, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', options)
  vim.api.nvim_buf_set_keymap(bufn, 'n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', options)
  vim.api.nvim_buf_set_keymap(bufn, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', options)
  print("LSP attached on buffer", bufn)
end

local default_capabilities = require('cmp_nvim_lsp').default_capabilities()

local server_configs = {
  ['default'] = {
    on_attach = default_on_attach,
    capabilities = default_capabilities
  },
  ['sumneko_lua'] = {
    on_attach = default_on_attach,
    capabilities = default_capabilities,
    settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim', 'use' }
        }
      }
    }
  }
}

for _, server in ipairs(masonlspconfig.get_installed_servers()) do
  if server_configs[server] ~= nil then
    lspconfig[server].setup(server_configs[server])
  else
    lspconfig[server].setup(server_configs['default'])
  end
end

-- add bemol files to workspace if available
local ws_folders_lsp = {}
local file = io.open("../../.bemol/ws_root_folders", "r");
if file then
  for line in file:lines() do
    table.insert(ws_folders_lsp, line);
  end
  file:close()
end

for _, line in ipairs(ws_folders_lsp) do
  vim.lsp.buf.add_workspace_folder(line)
end

-- integrate autopairs
cmp.event:on('confirm_done',
  require 'nvim-autopairs.completion.cmp'.on_confirm_done({
    map_char = { tex = '' }
  })
)


-- Language Overrides
-------------------------------------------------------------------------------

-- kotlin
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'kotlin',
  command = [[setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent]]
})

-- python
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'python',
  command = [[setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent]]
})

-- go
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'go',
  command = [[setlocal shiftwidth=6 tabstop=6 noexpandtab autoindent]]
})

-- Linting
-------------------------------------------------------------------------------

-- auto-format with :Fmt
vim.api.nvim_create_user_command('Fmt', [[lua vim.lsp.buf.format()]], {})
