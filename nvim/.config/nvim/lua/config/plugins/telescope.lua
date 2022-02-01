local telescope = require("telescope")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

telescope.setup {
  defaults = {
    -- winblend = 30,
    prompt_prefix = '🔍 ',
    selection_caret = " ",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<M-p>"] = action_layout.toggle_preview
      },
    },
  },
  pickers = {
    lsp_code_actions = {
      theme = "cursor",
    },
    find_files = {
      theme = "dropdown",
      previewer = false,
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor()
    }
  }
}

telescope.load_extension("ui-select")
