require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
  ensure_installed = vim.g.treesitter_parsers,
  indent = {
    enable = true,
  },
})
