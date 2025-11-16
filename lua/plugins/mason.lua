-- lua/plugins/mason.lua

return {
  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "phpcbf",
        "prettier",
        "djlint", -- Linter для Twig (та інших HTML templates)
      },
    },
  },
}
