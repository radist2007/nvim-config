-- lua/plugins/codecompanion.lua
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- Опціонально, для вибору промптів
      {
        "MeanderingProgrammer/render-markdown.nvim", -- Для гарного рендерингу markdown в чаті
        ft = { "markdown", "codecompanion" },
      },
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "anthropic",
          },
          inline = {
            adapter = "anthropic",
          },
          agent = {
            adapter = "anthropic",
          },
        },
        adapters = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "ANTHROPIC_API_KEY",
              },
              schema = {
                model = {
                  default = "claude-sonnet-4-5-20250929",
                },
              },
            })
          end,
        },
        display = {
          chat = {
            window = {
              layout = "vertical", -- vertical | horizontal | float
              width = 0.45, -- Ширина чат-вікна (45% екрану)
              height = 0.8,
              relative = "editor",
            },
            show_settings = true, -- Показувати налаштування моделі в чаті
          },
          diff = {
            provider = "mini_diff", -- default | mini_diff
          },
        },
        opts = {
          log_level = "DEBUG", -- TRACE | DEBUG | ERROR | INFO
        },
      })
    end,
  },
}
