require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true
    },
    ensure_installed = vim.g.supported_languages,
    indent = {
      enable = true
    }
}
