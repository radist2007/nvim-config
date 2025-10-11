-- lua/plugins/treesitter.lua

-- Призначення: Цей файл відповідає за налаштування nvim-treesitter,
-- який забезпечує розширену підсвітку синтаксису (більш точну та детальну, ніж стандартна),
-- а також може використовуватися для покращення відступів, навігації по коду тощо.

return {

  {
    "nvim-treesitter/nvim-treesitter",
    -- Переконайся, що LazyVim додає build = ":TSUpdate" або auto_install = true десь у своїх дефолтах,
    -- або додай build = ":TSUpdate" сюди, якщо потрібно.
    -- build = ":TSUpdate",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
        "twig",
        "php",
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "vim",
        "yaml",
      })
      -- Можна додати налаштування highlight та indent сюди, якщо хочеш перевизначити дефолт LazyVim
      -- opts.highlight = { enable = true }
      -- opts.indent = { enable = true }
    end,
  },
} -- Кінець return
