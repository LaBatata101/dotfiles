lua << EOF
require('telescope').setup {
    defaults = {
        prompt_prefix = '🔍 ',
        selection_caret = " ",
    },
    pickers = {
        lsp_code_actions = {
            theme = "cursor",
        },
        find_files = {
            theme = "dropdown",
            previewer = false,
        }
    }
}
EOF
