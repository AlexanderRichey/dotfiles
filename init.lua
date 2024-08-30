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
    branch = 'master',
    config = function()
      vim.g.VM_maps = {
        -- disable backspace mapping to prevent conflict with autopairs
        ["I BS"] = '',
      }
    end
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
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      { 'williamboman/mason.nvim' }, -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' }, -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'hrsh7th/cmp-buffer' }, -- Optional
      { 'hrsh7th/cmp-path' }, -- Optional
      { 'hrsh7th/cmp-cmdline' }, -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' }, -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' }, -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          -- "go",
          -- "javascript",
          -- "typescript",
          -- "python",
          -- "java",
          -- "kotlin",
          -- "bash",
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
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup {}
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


-- LSP
-------------------------------------------------------------------------------

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

--- if you want to know more about lsp-zero and mason.nvim
--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

lsp_zero.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = ''
})

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    style = 'minimal',
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },
})

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()
local cmp_format = lsp_zero.cmp_format()

require('luasnip.loaders.from_vscode').lazy_load()

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

cmp.setup({
  formatting = cmp_format,
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  mapping = cmp.mapping.preset.insert({
    -- confirm completion item
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- toggle completion menu
    ['<C-e>'] = cmp_action.toggle_completion(),

    -- tab complete
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),

    -- navigate between snippet placeholder
    ['<C-d>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- scroll documentation window
    ['<C-f>'] = cmp.mapping.scroll_docs(5),
    ['<C-u>'] = cmp.mapping.scroll_docs(-5),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

-- integrate autopairs
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on(
--   'confirm_done',
--   cmp_autopairs.on_confirm_done()
-- )

-- cmdline autocompletion
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- add bemol files to workspace if available
local file = io.open("../../.bemol/ws_root_folders", "r");
if file then
  for line in file:lines() do
    vim.lsp.buf.add_workspace_folder(line)
  end
  file:close()
end


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

-- auto-format
vim.api.nvim_create_user_command('Fmt', [[lua vim.lsp.buf.format()]], {})
