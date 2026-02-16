return {
  -- Colorscheme
  { "navarasu/onedark.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },

  -- Languages
  { "jasdel/vim-smithy" },

  -- Essentials
  { "tpope/vim-vinegar" },
  { "tpope/vim-surround" },

  -- Tmux
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true,
      })
    end,
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
