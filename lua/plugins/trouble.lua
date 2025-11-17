-- lua/plugins/trouble.lua
-- Призначення: Налаштування trouble.nvim - зручний інтерфейс для перегляду та навігації по:
-- - Діагностиці LSP (помилки, попередження, інформація, підказки)
-- - Результатах пошуку (fzf-lua або Telescope)
-- - Списках Quickfix та Location list
-- - LSP Посиланнях, Визначеннях, Реалізаціях
--
-- Гарячі клавіші (LazyVim defaults):
-- <leader>xx: Діагностика поточного документа
-- <leader>xX: Діагностика всього робочого простору (проекту)
-- <leader>xL: Location List
-- <leader>xQ: Quickfix List
--
-- З fzf-lua: Ctrl+t відкриває результати пошуку в Trouble

return {
  -- Налаштування Trouble
  {
    "folke/trouble.nvim",
    -- opts об'єднаються з налаштуваннями LazyVim за замовчуванням
    opts = {
      use_diagnostic_signs = true, -- Показувати іконки діагностики (помилка/попередження) всередині списку Trouble
    },
  },
}
