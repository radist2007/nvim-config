-- lua/plugins/avante.lua
return {
  "yetone/avante.nvim",
  event = "VeryLazy", -- Або "BufReadPre", "BufNewFile" якщо хочеш раніше
  build = "make", -- Розкоментуй, якщо хочеш збирати з джерел і маєш 'cargo'

  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter", -- Рекомендовано для кращого аналізу коду
    "stevearc/dressing.nvim", -- Для кращого UI
    -- Додай інші опціональні залежності з README avante.nvim, якщо вони тобі потрібні:
    -- "echasnovski/mini.pick",
    -- "nvim-telescope/telescope.nvim",
    -- "ibhagwan/fzf-lua",
    -- "nvim-tree/nvim-web-devicons", -- Або echasnovski/mini.icons
  },
  config = function()
    -- Згідно з документацією, може знадобитися викликати це для деяких функцій
    -- pcall(require, "avante_lib").load()
    print("AVANTE DEBUG: Calling avante_lib.load()...")
    local lib_ok, avante_lib = pcall(require, "avante_lib")
    if lib_ok then
      avante_lib.load()
      print("AVANTE DEBUG: avante_lib.load() successful.")
    else
      print("AVANTE ERROR: Failed to require or load 'avante_lib': " .. tostring(avante_lib))
      vim.notify(
        "Failed to load avante_lib for Avante.nvim. Templates/tokenizers might be missing.",
        vim.log.levels.ERROR
      )
    end

    require("avante").setup({
      -- Обираємо провайдера. Для Gemini це може бути "gemini" або "google".
      -- Судячи з деяких обговорень, "gemini" є правильним для avante.nvim
      provider = "gemini",

      gemini = {
        -- Модель. Перевір доступні моделі Gemini API, наприклад:
        -- "gemini-1.5-flash-latest" (швидка і дешевша)
        -- "gemini-1.5-pro-latest" (потужніша)
        -- "gemini-1.0-pro"
        model = "gemini-1.5-flash-latest",

        -- API ключ зазвичай підхоплюється зі змінної оточення GOOGLE_API_KEY або GEMINI_API_KEY.
        -- Якщо потрібно вказати явно команду для отримання ключа (менш безпечно):
        -- api_key_cmd = "cat /шлях/до/твого/файлу_з_ключем_gemini",

        -- Інші можливі налаштування для Gemini (дивись документацію avante.nvim):
        -- temperature = 0.7,
        -- max_tokens = 8192,
        -- timeout = 30000,
      },

      -- Можна налаштувати UI, наприклад, позицію сайдбару
      sidebar = {
        width = 60, -- Ширина сайдбару
        -- ... інші опції UI ...
      },

      -- Якщо ти використовував proxy для OpenAI, можливо, він потрібен і тут
      -- proxy = "http://127.0.0.1:7890",

      -- Інші загальні налаштування avante.nvim
      -- log_level = "debug", -- Для детальних логів
    })
    print("AVANTE.NVIM: Configured for Gemini.")
  end,
}
