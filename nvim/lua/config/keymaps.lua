-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Map find_files to ctrl-p
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })

-- Map live_grep to \-f
vim.keymap.set("n", "<localleader>f", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })

-- Tmux
vim.keymap.set("n", "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>", { noremap = true, silent = true })
