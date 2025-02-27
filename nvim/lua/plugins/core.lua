return {
  -- Colorscheme
  { "navarasu/onedark.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },

  -- Essentials
  { "tpope/vim-vinegar" },
  { "tpope/vim-surround" },

  -- Tmux
  {
    "alexghergh/nvim-tmux-navigation",
    config = function ()
      require("nvim-tmux-navigation").setup({})
    end
  },

  -- MultiCursor
  {
    "mg979/vim-visual-multi",
    branch = "master",
    config = function()
      vim.g.VM_maps = {
        -- disable backspace mapping to prevent conflict with autopairs
        ["I BS"] = '',
      }
    end
  },

  -- Tab through autocomplete suggestions
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = 'enter',
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
      }
    }
  }
}
