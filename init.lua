-- /home/radist/.config/nvim/init.lua

-- bootstrap lazy.nvim, LazyVim and your plugins

vim.lsp.set_log_level("debug") -- 1. Встановлює рівень логування LSP на DEBUG
vim.g.lazyvim_check_order = false -- 2. Вимикає перевірку порядку імпорту LazyVim

require("config.lazy") -- 3. Завантажує та виконує файл lua/config/lazy.lua
