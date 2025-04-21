-- Новий файл: lua/plugins/telescope-config.lua
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  vim.notify("Telescope plugin not found!", vim.log.levels.WARN)
  return
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = "❯ ",
    path_display = { "truncate" },
    mappings = {
      i = { ["<C-j>"] = actions.move_selection_next, ["<C-k>"] = actions.move_selection_previous, ["<esc>"] = actions.close },
      n = { ["<C-j>"] = actions.move_selection_next, ["<C-k>"] = actions.move_selection_previous, ["q"] = actions.close },
    },
  },
  pickers = { find_files = { } },
  extensions = { },
})
print("TELESCOPE DEBUG: Configured via telescope-config.lua") -- Додамо print
