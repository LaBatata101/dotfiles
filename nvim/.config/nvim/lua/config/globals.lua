vim.g.supported_languages = { "rust", "python", "lua", "c", "vim" }

vim.g.treesitter_parsers = { "rust", "python", "lua", "c", "vim", "comment" }
-- vim.tbl_extend("force", vim.g.treesitter_parsers, vim.g.supported_languages)
-- table.insert(vim.g.treesitter_parsers, "comment")

vim.g.language_servers = {
  "pyright",
  "rust_analyzer",
  "sumneko_lua",
}
