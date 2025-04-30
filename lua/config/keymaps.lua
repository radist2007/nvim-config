-- lua/config/keymaps.lua

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Скорочення для функції та опції
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Мапінг для ToggleTerm на Ctrl+\ (в Нормальному і Термінальному режимах)
map({ "n", "t" }, "<C-\\>", "<Cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })

-- Навігація між буферами:
map("n", "<S-l>", ":bnext<CR>", opts) -- Наступний буфер (Shift+L)
map("n", "<S-h>", ":bprevious<CR>", opts) -- Попередній буфер (Shift+H)
