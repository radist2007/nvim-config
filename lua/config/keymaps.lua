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
map("t", "<c-/>", function()
  Snacks.terminal()
end, { desc = "Toggle Terminal" })

-- Термінал справа через leader (Space+tr)
map("n", "<leader>tr", function()
  vim.cmd("ToggleTerm size=80 direction=vertical")
end, { desc = "Terminal Right" })

-- Навігація між буферами:

map("n", "<S-l>", ":bnext<CR>", opts) -- Наступний буфер (Shift+L)
map("n", "<S-h>", ":bprevious<CR>", opts) -- Попередній буфер (Shift+H)

-- Claude Code keymaps визначені в LazyVim extra ai.claudecode
-- <leader>ac - Toggle Claude Code
-- <leader>af - Focus вікно
-- <leader>ar - Resume сесію
-- <leader>aC - Continue сесію
-- <leader>ab - Додати поточний буфер
-- <leader>as - Надіслати виділення (visual)
-- <leader>aa - Прийняти diff
-- <leader>ad - Відхилити diff

-- Персональна шпаргалка по гарячих клавішах
map("n", "<leader>ch", function()
  -- Текст шпаргалки
  local lines = {
    " СПАРГАЛКА ",
    "──────────────────",
    " <leader>uz - Дзен-режим",
    " <leader>uD - Затемнення неактивного коду",
    " <leader>ua - Увімк./Вимк. анімації",
    " Ctrl+\\ : термінал по центру (floating)",
    " Ctrl+/ : термінал знизу (Snacks)",
    " Space+tr : термінал справа (ToggleTerm)",
    "──────────────────",
    " FZF-LUA (швидкий пошук):",
    " <leader>ff - Знайти файли",
    " <leader>/ або <leader>fg - Пошук тексту",
    " <leader>fb - Відкриті буфери",
    "──────────────────",
    " TELESCOPE (детальний preview):",
    " <leader>tf - Знайти файли",
    " <leader>tg - Пошук тексту (grep)",
    " <leader>tb - Відкриті буфери",
    " <leader>ts - Символи (LSP)",
    " <leader>td - Діагностика",
    " <leader>th - Довідка",
    "──────────────────",
    " CLAUDE CODE:",
    " <leader>ac - Toggle Claude Code",
    " <leader>af - Focus вікно",
    " <leader>ar - Resume сесію",
    " <leader>ab - Додати буфер до контексту",
    " <leader>as - Надіслати виділення (visual)",
    " <leader>aa - Прийняти diff",
    " <leader>ad - Відхилити diff",
    "──────────────────",
    " Натисніть q, щоб закрити",
  }

  -- Створюємо 'scratch' буфер (без файлу, тимчасовий)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Розраховуємо розміри та позицію вікна, щоб було по центру
  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, #line)
  end
  width = width + 4 -- Додаємо відступи
  local height = #lines + 2
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Створюємо спливаюче вікно
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  -- Мапінг для закриття вікна по клавіші 'q'
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, silent = true })
end, { desc = "Show personal keymap cheatsheet" })
