-- lua/plugins/lsp-servers.lua

return {

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      -- Список LSP серверів, які мають бути встановлені Mason
      ensure_installed = {
        "lua_ls",
        "intelephense",
        "tsp_server",
        "html",
        "cssls",
        "emmet_ls",
        "jsonls",
        "marksman", -- Для Markdown
        "dockerls", -- Для Dockerfile
        -- "pyright",
        -- "bashls",
        -- "tailwindcss",
      },
      -- Тут можуть бути інші опції mason-lspconfig, наприклад:
      -- automatic_installation = true, -- Зазвичай true за замовчуванням у LazyVim
    },
  },
}
