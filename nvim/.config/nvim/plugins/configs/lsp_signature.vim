lua << EOF
require "lsp_signature".setup({
    transpancy = nil,
    floating_window = true,
    doc_lines = 0,
    hint_enable = false,
    handler_opts = {
        border = "none"   -- double, single, shadow, none
    },
})
EOF
