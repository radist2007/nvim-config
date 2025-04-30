-- lua/config/options.lua

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.number = true -- Показувати номери рядків
vim.opt.relativenumber = true -- Показувати відносні номери рядків
vim.opt.tabstop = 2 -- Розмір табуляції = 2 пробіли
vim.opt.shiftwidth = 2 -- Розмір відступу = 2 пробіли
vim.opt.expandtab = true -- Використовувати пробіли замість символів табуляції
vim.opt.termguicolors = true -- Увімкнути підтримку True Color (ВАЖЛИВО для тем)
vim.opt.mouse = "a" -- Увімкнути підтримку миші у всіх режимах
vim.opt.clipboard = "unnamedplus" -- Використовувати системний буфер обміну (+) - ВАЖЛИВО!
vim.opt.splitright = true -- Нові вертикальні розділення відкривати праворуч
vim.opt.splitbelow = true -- Нові горизонтальні розділення відкривати знизу
vim.opt.scrolloff = 8 -- Залишати 8 рядків видимості зверху/знизу від курсору
vim.opt.signcolumn = "yes" -- Завжди показувати колонку для знаків (LSP, GitSigns, DAP)
vim.opt.updatetime = 300 -- Час (мс) бездіяльності для спрацювання CursorHold (LSP, GitSigns)
vim.opt.timeoutlen = 500 -- Час (мс) очікування для послідовності клавіш

-- Пошук:
vim.opt.ignorecase = true -- Ігнорувати регістр при пошуку
vim.opt.smartcase = true -- Чутливий до регістру, якщо є велика літера
vim.opt.hlsearch = true -- Підсвічувати результати пошуку
vim.opt.incsearch = true -- Інкрементний пошук

-- Редагування:
vim.opt.wrap = false -- Вимкнути перенесення рядків

-- Інтерфейс:
vim.opt.cmdheight = 1 -- Висота командного рядка
vim.opt.pumheight = 10 -- Макс. висота спливаючого меню

-- Встановлюємо спрощений набір опцій для сесії, щоб уникнути помилки E474
-- vim.opt.sessionoptions = "buffers,curdir,localoptions,tabpages,winsize"
vim.opt.sessionoptions = "buffers,curdir,localoptions,tabpages,winsize"
