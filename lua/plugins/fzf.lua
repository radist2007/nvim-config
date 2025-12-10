-- lua/plugins/fzf.lua
-- Налаштування fzf-lua як основного picker з додатковою підтримкою Telescope
-- LazyVim 14.x+ рекомендує fzf-lua для кращої швидкодії
-- Але Telescope залишається для складніших задач з кращим preview

return {
  -- Імпортуємо LazyVim extra для fzf-lua (основний пікер)
  { import = "lazyvim.plugins.extras.editor.fzf" },

  -- Імпортуємо Telescope як додатковий пікер
  { import = "lazyvim.plugins.extras.editor.telescope" },

  -- Telescope буде доступний паралельно через інші клавіші
  {
    "nvim-telescope/telescope.nvim",
    enabled = true, -- Увімкнено!
    keys = {
      -- Telescope під префіксом <leader>t (telescope)
      { "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Telescope: Find Files" },
      { "<leader>tg", "<cmd>Telescope live_grep<cr>", desc = "Telescope: Grep" },
      { "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Telescope: Buffers" },
      { "<leader>th", "<cmd>Telescope help_tags<cr>", desc = "Telescope: Help" },
      { "<leader>ts", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Telescope: Symbols" },
      { "<leader>td", "<cmd>Telescope diagnostics<cr>", desc = "Telescope: Diagnostics" },
    },
  },

  -- fzf-lua залишається основним (через leader без префіксу)
  -- <leader>ff - fzf find files
  -- <leader>fg або <leader>/ - fzf grep
  -- <leader>fb - fzf buffers
}
