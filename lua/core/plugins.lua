-- lua/core/plugins.lua

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazy_path,
  })
end
vim.opt.rtp:prepend(lazy_path)

-- Основний блок налаштування lazy.nvim
require("lazy").setup({
  -- Ядра / Утиліти
  "nvim-neotest/nvim-nio",
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",

  -- Telescope 
    {
      "nvim-telescope/telescope.nvim",
      -- Тег не потрібен
      dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
      cmd = "Telescope",
      keys = { "<leader>f", "<leader>g", "<leader>b" },
      config = function()
         -- Використовуємо нову назву файлу!
         require("plugins.telescope-config")
      end
    },

  -- lua/core/plugins.lua (запис для tokyonight)
{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
      print("UI DEBUG: Requiring plugins.ui...")
      local ui_ok, _ = pcall(require, "plugins.ui")
      if not ui_ok then
         print("UI ERROR: Failed to require plugins.ui")
         vim.notify("ERROR: Failed to require plugins.ui", vim.log.levels.ERROR)
      else
         print("UI DEBUG: Required plugins.ui OK.")
      end
      -- Явно встановлюємо тему ПІСЛЯ спроби завантажити ui.lua
      print("UI DEBUG: Setting colorscheme to tokyonight...")
      vim.cmd.colorscheme "tokyonight"
      print("UI DEBUG: Colorscheme set command executed.")
  end
},
  "nvim-neo-tree/neo-tree.nvim",
  "akinsho/toggleterm.nvim",

{
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { -- Переконайся, що всі залежності тут
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    print("LSP DEBUG: Running config directly in plugins.lua...")
    -- === ПОЧАТОК ВМІСТУ З lsp.lua ===
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup() -- Запускаємо mason.setup тут

    mason_lspconfig.setup({ -- Налаштовуємо mason-lspconfig
      ensure_installed = {
        "intelephense",
        "tsp_server", -- Правильне ім'я
        "html",
        "cssls",
        "emmet_ls",
        "lua_ls"
      },
    })

    -- Отримуємо capabilities ПІСЛЯ завантаження залежностей
    local capabilities_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = {}
    if capabilities_ok then
        capabilities = cmp_nvim_lsp.default_capabilities()
        print("LSP DEBUG: CMP capabilities loaded.")
    else
        print("LSP WARN: Failed to load cmp_nvim_lsp capabilities.")
        vim.notify("WARN: Failed to load cmp_nvim_lsp capabilities for LSP!", vim.log.levels.WARN)
    end

    -- Налаштовуємо обробники
    mason_lspconfig.setup_handlers({
      function(server_name)
        print("LSP DEBUG: Setting up handler for: " .. server_name)
        lspconfig[server_name].setup({ -- Використовуємо змінну
          capabilities = capabilities,
        })
      end,
    })
    -- === КІНЕЦЬ ВМІСТУ З lsp.lua ===
    print("LSP DEBUG: Finished direct config in plugins.lua.")
  end -- Кінець config функції
}, -- Кінець таблиці для nvim-lspconfig-- Інші LSP/CMP плагіни не потребують config, бо налаштовуються в lsp.lua

  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui" },
    -- Можливо, додати 'event' або 'cmd' для лінивого завантаження
    config = function()
      require("plugins.dap") -- Завантажуємо ВЕСЬ DAP конфіг тут
    end
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- Завантажувати при відкритті файлів
    config = function()
      -- Якщо є файл lua/plugins/gitsigns.lua: require("plugins.gitsigns")
      -- Якщо ні, базове налаштування:
      require('gitsigns').setup()
    end
  },

  -- ChatGPT (Тут було правильно)
  {
    "jackMort/ChatGPT.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    cmd = "ChatGPT", -- Ліниве завантаження по команді
    keys = { "<leader>cg" }, -- Ліниве завантаження по клавішах
    config = function() require("plugins.chatgpt") end
  },

  -- { "user/plugin-x", config = function() require("plugins.project_context") end },

})
