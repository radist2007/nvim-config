-- /home/radist/.config/nvim/init.lua

-- bootstrap lazy.nvim, LazyVim and your plugins

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded" },
})

-- Вимикає перевірку порядку імпорту LazyVim, щоб уникнути попереджень
-- при використанні кастомних плагінів та оверрайдів
vim.g.lazyvim_check_order = false

require("config.lazy") -- Завантажує та виконує файл lua/config/lazy.lua
