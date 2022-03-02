vim.g.supported_languages = { "rust", "python", "lua", "c", "vim" }

vim.g.treesitter_parsers = {}
table.insert(vim.g.treesitter_parsers, vim.g.supported_languages)
table.insert(vim.g.treesitter_parsers, "comment")

vim.g.language_servers = {
  "pyright",
  "rust-analyzer",
  "sumneko_lua",
}
