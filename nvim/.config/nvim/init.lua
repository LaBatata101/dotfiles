require("config.settings")
require("config.keymaps")

require("config.plugins.packer")

-- Improve startup speed
require("impatient")

require("packer_compiled")
-- load plugins configurations
require("config.plugins.treesitter")
require("config.plugins.lsp")
require("config.plugins.cmp")
require("config.plugins.hop")
require("config.plugins.fidget")
require("config.plugins.comment")
require("config.plugins.lualine")
require("config.plugins.trouble")
require("config.plugins.autopairs")
require("config.plugins.lightbulb")
require("config.plugins.neoscroll")
require("config.plugins.telescope")
require("config.plugins.bufferline")
require("config.plugins.illuminate")
require("config.plugins.tokyonight")
require("config.plugins.lsp_signature")
require("config.plugins.indent_blankline")
