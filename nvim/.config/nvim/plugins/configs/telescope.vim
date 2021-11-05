lua << EOF
require('telescope').setup {
    defaults = {
        prompt_prefix = '🔍 ',
        selection_caret = " ",
    }
}
EOF
