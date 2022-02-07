require("null-ls").setup({
  sources = {
    -- require("null-ls").builtins.formatting.autopep8,
    require("null-ls").builtins.formatting.stylua.with({
      extra_args = { "--indent_type", "Spaces", "--indent_width", "2" },
    }),
  },
})
