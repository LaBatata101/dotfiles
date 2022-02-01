require("config.globals")
require("config.settings")
require("config.keymaps")

pcall(require, "impatient")

require("config.plugins.packer")

-- Improve startup speed
-- require("impatient")

require("packer_compiled")
-- load plugins configurations
require("config.plugins.cmp")
require("config.plugins.hop")
require("config.plugins.comment")
require("config.plugins.lualine")
require("config.plugins.autopairs")
require("config.plugins.neoscroll")
require("config.plugins.bufferline")
require("config.plugins.illuminate")
require("config.plugins.tokyonight")
