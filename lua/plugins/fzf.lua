-- lua/plugins/fzf.lua
-- Налаштування fzf-lua як основного picker замість telescope
-- LazyVim 14.x+ рекомендує fzf-lua для кращої швидкодії

return {
  -- Імпортуємо LazyVim extra для fzf-lua
  -- Це автоматично налаштує fzf-lua та вимкне telescope
  { import = "lazyvim.plugins.extras.editor.fzf" },

  -- Вимикаємо telescope на користь fzf-lua
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
  },
}
