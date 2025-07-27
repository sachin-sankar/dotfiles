-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Visual mode: Shift+Y copies to system clipboard
vim.keymap.set("v", "Y", '"+y', { noremap = true, silent = true })
