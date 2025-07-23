-- lua/config/keymaps.lua

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Скорочення для функції та опції
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Мапінг для ToggleTerm видалено, оскільки він керується плагіном напряму

-- Вихід з терміналу в нормальний режим
map("t", "<C-o>", "<C-\\><C-N>", { noremap = true, desc = "Exit Terminal Mode" })

-- Термінал справа через leader (Space+tr)
map("n", "<leader>tr", function()
  vim.cmd("ToggleTerm size=80 direction=vertical")
end, { desc = "Terminal Right" })

-- Навігація між буферами:

map("n", "<S-l>", ":bnext<CR>", opts) -- Наступний буфер (Shift+L)
map("n", "<S-h>", ":bprevious<CR>", opts) -- Попередній буфер (Shift+H)

-- Тимчасовий мапінг для діагностики filetype
vim.keymap.set("n", "<F7>", function()
  local bufnr = vim.api.nvim_get_current_buf() -- Отримуємо номер поточного буфера
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype") -- Отримуємо його filetype
  local bufname = vim.api.nvim_buf_get_name(bufnr) -- Отримуємо ім'я буфера
  local msg = string.format("DEBUG INFO -- Buffer: %d, Name: '%s', Filetype: '%s'", bufnr, bufname, ft)

  vim.cmd("echohl None") -- Очистити попереднє підсвічування повідомлень
  vim.cmd("echomsg '" .. msg:gsub("'", "''") .. "'") -- Вивести повідомлення і додати в :messages
  -- msg:gsub("'", "''") екранує одинарні лапки
  print(msg) -- Також вивести у :messages через print для надійності
end, { noremap = true, silent = true, desc = "Print current buffer filetype" })
