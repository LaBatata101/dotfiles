require("ibl").setup({
  indent = { char = "▏" },
  exclude = {
    filetypes = {
      "text",
      "lsp-installer",
      "dapui_scopes",
      "dapui_stacks",
      "dapui_watches",
      "dapui_breakpoints",
      "Trouble",
    },
    buftypes = { "lsp-installer" },
  },
  scope = {
    show_start = false,
    show_end = false,
  },
})
