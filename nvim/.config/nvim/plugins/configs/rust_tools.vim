lua << EOF
local rust_tools = require("rust-tools")

rust_tools.setup {
    tools = {
        autoSetHints = true,
        hover_with_actions = false,

        inlay_hints = {
            show_parameter_hints = false,

            parameter_hints_prefix = "",
            other_hints_prefix = "» ",

            highlight = "Comment",
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
                { "╭", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╮", "FloatBorder" },
                { "│", "FloatBorder" },
                { "╯", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╰", "FloatBorder" },
                { "│", "FloatBorder" },
                },

            -- whether the hover action window gets automatically focused
            auto_focus = true,
        },
    }
}
EOF
