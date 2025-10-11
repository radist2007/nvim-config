-- /home/radist/.config/nvim/init.lua

-- bootstrap lazy.nvim, LazyVim and your plugins

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded" },
})
vim.g.lazyvim_check_order = false -- 2. Вимикає перевірку порядку імпорту LazyVim

require("config.lazy") -- 3. Завантажує та виконує файл lua/config/lazy.lua
