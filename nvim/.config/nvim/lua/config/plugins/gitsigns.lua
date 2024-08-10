require("gitsigns").setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "▎" },
    topdelete = {
      text = "契",
    },
    changedelete = {
      text = "▎",
    },
  },
  sign_priority = 6,
})
