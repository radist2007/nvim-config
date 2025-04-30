-- lua/plugins/lang-exptras.lua

return {
  { import = "lazyvim.plugins.extras.lang.typescript" },
  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" }, -- <<< РОЗКОМЕНТУЙ ЦЕЙ РЯДОК
}
