-- core/keymaps.lua

vim.g.mapleader = ' ' -- Встановити Space як <leader> (дуже поширений варіант)
-- Або: vim.g.mapleader = ',' -- Встановити , як <leader>

local map = vim.keymap.set -- Зручне скорочення для функції мапінгу
local opts = { noremap = true, silent = true } -- Стандартні опції для більшості мапінгів

-- Навігація / Перемикачі
--map("n", "<leader>e", ":Neotree toggle<CR>", opts) -- Перемкнути файлове дерево Neo-tree
map("n", "<leader>tt", ":ToggleTerm<CR>", opts)   -- Перемкнути термінал ToggleTerm
map("n", "<leader>cg", ":ChatGPT<CR>", opts)      -- Відкрити запит ChatGPT

-- Збереження / Вихід
--map("n", "<C-s>", ":w<CR>", opts)               -- Зберегти файл (Ctrl+S)
--map("n", "<C-q>", ":q<CR>", opts)               -- Закрити вікно/Vim (Ctrl+Q)

-- Навігація між буферами:
map("n", "<S-l>", ":bnext<CR>", opts) -- Наступний буфер (Shift+L)
map("n", "<S-h>", ":bprevious<CR>", opts) -- Попередній буфер (Shift+H)
-- map("n", "<leader>bd", ":bdelete<CR>", opts) -- Закрити поточний буфер

-- Telescope Mappings (Додаємо ці рядки)
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files", noremap = true, silent = true }) -- Пошук файлів
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep", noremap = true, silent = true })   -- Пошук тексту в проекті
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers", noremap = true, silent = true })  -- Пошук відкритих буферів
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find Help", noremap = true, silent = true })   -- Пошук по довідці Vim


map("n", "<leader>e", "<Cmd>Neotree toggle<CR>", { desc = "Toggle NeoTree", noremap = true, silent = true })

-- Інші корисні пікери Telescope:
-- map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Find Old Files", noremap = true, silent = true })
-- map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find Keymaps", noremap = true, silent = true })

