-- lua/plugins/mason.lua

return {
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "phpcbf",
        "prettier",
        -- Додай сюди інші форматери/лінтери, якщо потрібно
      },
    },
  },
}
