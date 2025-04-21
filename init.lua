-- init.lua
vim.lsp.set_log_level("debug")
require("core.options")
require("core.keymaps")
require("core.plugins") -- Цей файл тепер керує завантаженням плагінів та їх конфігів

-- Переконайся, що ці рядки закоментовані або видалені:
-- require("plugins.lsp") -- ВИДАЛИТИ АБО ЗАКОМЕНТУВАТИ
-- require("plugins.ui")
-- require("plugins.dap")
-- require("plugins.chatgpt") -- Завантажується через lazy.nvim -> config
-- require("plugins.telescope-config") -- Завантажується через lazy.nvim -> config
-- require("plugins.project_context") -- ??? (Доля цього рядка невідома)
