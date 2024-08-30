-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- auto-format
vim.api.nvim_create_user_command('Fmt', [[lua vim.lsp.buf.format()]], {})
