return {
  "nvim-lua/plenary.nvim",
  config = function()
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = "*.twig",
      callback = function()
        vim.bo.filetype = "twig"
      end,
    })
  end,
}
