require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true
    },
    ensure_installed = {
        "python",
        "rust",
        "vim",
        "lua"
    }
}
