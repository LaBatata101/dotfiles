require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
  ensure_installed = { "rust", "python", "lua", "c", "vim", "comment" },
  indent = {
    enable = true,
    disable = { "python" },
  },
})
