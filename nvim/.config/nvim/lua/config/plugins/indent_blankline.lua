require("indent_blankline").setup {
  char_list = {'|', '¦', '┆', '┊'},
  filetype_exclude = {
    "text",
    "help",
    "lsp-installer",
    "dapui_scopes",
    "dapui_stacks",
    "dapui_watches",
    "dapui_breakpoints",
  },
  show_first_indent_level = false,
  show_trailing_blankline_indent = false,
  show_current_context = true,
  show_current_context_start = false,
}
