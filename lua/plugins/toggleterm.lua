-- lua/plugins/toggleterm.lua
-- TODO: розглянути варіан ці стандартним терміналом <liader>fT прблема з незручним виходом з терміналу

return {
  "akinsho/toggleterm.nvim",
  version = "*", -- Або вкажи конкретну версію, якщо треба
  cmd = "ToggleTerm", -- <<< Важливо для реєстрації команди
  opts = {
    -- Тут твої бажані налаштування ToggleTerm, наприклад:
    direction = "float", -- Зміни на 'horizontal'/'vertical', якщо хочеш
    terminal_mappings = true, -- Потрібно для виходу по Esc
    insert_mappings = true, -- Дозволити мапінги в режимі вставки
    -- cwd = vim.fn.getcwd(),
    -- ... інші опції ...
  },
}
