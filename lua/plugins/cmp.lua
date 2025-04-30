-- lua/plugins/cmp.lua

-- Призначення файлу: Цей файл налаштовує плагін автодоповнення nvim-cmp (який є стандартним у LazyVim).

return {

  -- override nvim-cmp and add cmp-emoji
  {
    enable = false,
    "hrsh7th/nvim-cmp", -- Плагін автодоповнення
    dependencies = { "hrsh7th/cmp-emoji" }, -- Додаємо залежність від плагіна емодзі
    ---@param opts cmp.ConfigSchema -- Анотація типу для документації/LSP
    opts = function(_, opts)
      -- Додаємо джерело автодоповнення 'emoji' до списку існуючих джерел
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
}
