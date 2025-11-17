-- lua/config/lazy.lua

-- Рядки 1-16: Bootstrap lazy.nvim
-- Цей блок коду перевіряє, чи встановлено сам менеджер плагінів lazy.nvim.
-- Якщо ні, він автоматично клонує його з GitHub у стандартну директорію даних Neovim.
-- Потім він додає шлях до lazy.nvim на початок шляхів пошуку Neovim (rtp),
-- щоб команда require("lazy") спрацювала. Це стандартний код для запуску lazy.nvim.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ -- Обробка помилки, якщо git clone не вдався
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Рядок 18: Запуск налаштування lazy.nvim
require("lazy").setup({ -- Головна функція налаштування lazy.nvim

  -- Секція spec: Визначає, ЩО завантажувати
  spec = {
    -- 1. Спочатку імпортуємо *всі* стандартні плагіни та їх налаштування від LazyVim.
    -- Це основа, на якій будується решта. Порядок ВАЖЛИВИЙ!
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- 2. Потім імпортуємо ВСІ .lua файли з твоєї директорії lua/plugins/
    -- Саме тут знаходяться твої кастомні плагіни та перевизначення стандартних.
    -- Цей рядок має йти ПІСЛЯ імпорту lazyvim.plugins.
    { import = "plugins" },
  }, -- Кінець spec

  -- Секція defaults: Налаштування за замовчуванням для ТВОЇХ плагінів (з lua/plugins/)
  defaults = {
    -- lazy = true: Твої плагіни за замовчуванням ліниві (завантажуються при потребі - швидший старт).
    -- LazyVim автоматично визначає коли завантажувати плагіни (події, команди, клавіші).
    lazy = true,
    -- version = false: Завжди використовувати останню версію плагіна з Git.
    -- Рекомендовано LazyVim. Альтернатива version = "*" спробує знайти останній стабільний реліз.
    version = false,
  },

  -- Секція install: Опції для процесу початкового встановлення (:Lazy install/sync)
  install = {
    -- Встановлює перевагу тем при першому встановленні. Спробує tokyonight, потім habamax.
    colorscheme = { "tokyonight", "habamax" },
  },

  -- Секція checker: Налаштування перевірки оновлень плагінів
  checker = {
    enabled = true, -- Періодично перевіряти оновлення.
    notify = false, -- Не показувати повідомлення про наявність оновлень (можна перевірити вручну через :Lazy).
  },

  -- Секція performance: Оптимізації швидкодії
  performance = {
    rtp = {
      -- Вимикає деякі старі вбудовані плагіни Vim для потенційного пришвидшення старту.
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin", -- "netrwPlugin" (закоментований, бо LazyVim зазвичай ставить свій файловий менеджер)
      },
    },
  },
}) -- Кінець require("lazy").setup
